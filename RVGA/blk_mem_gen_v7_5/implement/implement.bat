
 
 
 




rem Clean up the results directory
rmdir /S /Q results
mkdir results

rem Synthesize the VHDL Wrapper Files


echo 'Synthesizing example design with XST';
xst -ifn xst.scr
copy blk_mem_gen_v7_5_exdes.ngc .\results\


rem Copy the netlist generated by Coregen
echo 'Copying files from the netlist directory to the results directory'
copy ..\..\blk_mem_gen_v7_5.ngc results\


rem  Copy the constraints files generated by Coregen
echo 'Copying files from constraints directory to results directory'
copy ..\example_design\blk_mem_gen_v7_5_exdes.ucf results\

cd results

echo 'Running ngdbuild'
ngdbuild -p xc6slx9-tqg144-3 blk_mem_gen_v7_5_exdes

echo 'Running map'
map blk_mem_gen_v7_5_exdes -o mapped.ncd  -pr i

echo 'Running par'
par mapped.ncd routed.ncd

echo 'Running trce'
trce -e 10 routed.ncd mapped.pcf -o routed

echo 'Running design through bitgen'
bitgen -w routed

echo 'Running netgen to create gate level VHDL model'
netgen -ofmt vhdl -sim -tm blk_mem_gen_v7_5_exdes -pcf mapped.pcf -w routed.ncd routed.vhd
