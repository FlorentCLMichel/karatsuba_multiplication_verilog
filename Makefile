clean: 
	rm -rf obj_dir
	rm -rf src/__pycache__

test:
	verilator -Wall --cc --exe --build tests/${name}.cpp tests/${name}.v --top-module ${name}
	obj_dir/V${name}
