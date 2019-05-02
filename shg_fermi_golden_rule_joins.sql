--JOIN SHG and FERMI TABLES

use fermi_golden_rule

select * from structures; select * from matrix_elements; select * from shg_data;
select structures.structure_id, shg_data.stoichiometry, shg_data.strain, shg_data.range2, shg_data.strain_direction 
into #struct_shg
from shg_data right join structures on shg_data.stoichiometry like structures.stoichiometry and 
shg_data.strain = structures.strain and
shg_data.strain_direction = structures.strain_direction;

select #struct_shg.stoichiometry, #struct_shg.range2, #struct_shg.strain, #struct_shg.strain_direction, matrix_elements.*
into #fermi_vs_shg from #struct_shg right join matrix_elements on #struct_shg.structure_id = matrix_elements.structure_id 

select * from #fermi_vs_shg where strain = 3