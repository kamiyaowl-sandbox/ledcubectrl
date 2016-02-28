/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    unisims_ver_m_00000000001946988858_2297623829_init();
    unisims_ver_m_00000000002399568039_2282143210_init();
    unisims_ver_m_00000000000740258969_3897995058_init();
    unisims_ver_m_00000000000740258969_1625843133_init();
    unisims_ver_m_00000000003131622635_0225263307_init();
    unisims_ver_m_00000000002922998384_2788049931_init();
    unisims_ver_m_00000000003266096158_2593380106_init();
    work_m_00000000000052663803_2187063399_init();
    work_m_00000000002687853959_1237171261_init();
    xilinxcorelib_ver_m_00000000001358910285_0969079128_init();
    xilinxcorelib_ver_m_00000000001687936702_2355456846_init();
    xilinxcorelib_ver_m_00000000000277421008_2747034111_init();
    xilinxcorelib_ver_m_00000000001603977570_2546062419_init();
    work_m_00000000002918048620_0975962166_init();
    work_m_00000000002729480044_3823007873_init();
    work_m_00000000003073960784_3622719947_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000003073960784_3622719947");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
