From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 3/3] serial: 8250_pci: remove exar code
Date: Sun, 15 Jan 2017 17:47:17 +0200
Message-ID: <CAHp75VfmutRv3wN2TVK3W0wsN1nxk9Rd6KZvHWO6yhPepzhsZg@mail.gmail.com>
References: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com> <1484434252-7663-3-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484434252-7663-3-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 15, 2017 at 12:50 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Remove the Exar specific codes from 8250_pci and blacklist those chips
> so that the new Exar serial driver binds to the devices.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 336 +------------------------------------
>  drivers/tty/serial/8250/Kconfig    |   1 +
>  2 files changed, 4 insertions(+), 333 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 116436b..0a232cf 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1605,9 +1605,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
>  #endif
>  }
>
> -#define PCI_DEVICE_ID_EXAR_XR17V4358   0x4358
> -#define PCI_DEVICE_ID_EXAR_XR17V8358   0x8358
> -
>  #define UART_EXAR_MPIOINT_7_0  0x8f    /* MPIOINT[7:0] */
>  #define UART_EXAR_MPIOLVL_7_0  0x90    /* MPIOLVL[7:0] */
>  #define UART_EXAR_MPIO3T_7_0   0x91    /* MPIO3T[7:0] */
> @@ -1620,71 +1617,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
>  #define UART_EXAR_MPIOINV_15_8 0x98    /* MPIOINV[15:8] */
>  #define UART_EXAR_MPIOSEL_15_8 0x99    /* MPIOSEL[15:8] */
>  #define UART_EXAR_MPIOOD_15_8  0x9a    /* MPIOOD[15:8] */
> -
> -static int
> -pci_xr17c154_setup(struct serial_private *priv,
> -                 const struct pciserial_board *board,
> -                 struct uart_8250_port *port, int idx)
> -{
> -       port->port.flags |= UPF_EXAR_EFR;
> -       return pci_default_setup(priv, board, port, idx);
> -}
> -
> -static inline int
> -xr17v35x_has_slave(struct serial_private *priv)
> -{
> -       const int dev_id = priv->dev->device;
> -
> -       return ((dev_id == PCI_DEVICE_ID_EXAR_XR17V4358) ||
> -               (dev_id == PCI_DEVICE_ID_EXAR_XR17V8358));
> -}
> -
> -static int
> -pci_xr17v35x_setup(struct serial_private *priv,
> -                 const struct pciserial_board *board,
> -                 struct uart_8250_port *port, int idx)
> -{
> -       u8 __iomem *p;
> -
> -       p = pci_ioremap_bar(priv->dev, 0);
> -       if (p == NULL)
> -               return -ENOMEM;
> -
> -       port->port.flags |= UPF_EXAR_EFR;
> -
> -       /*
> -        * Setup the uart clock for the devices on expansion slot to
> -        * half the clock speed of the main chip (which is 125MHz)
> -        */
> -       if (xr17v35x_has_slave(priv) && idx >= 8)
> -               port->port.uartclk = (7812500 * 16 / 2);
> -
> -       /*
> -        * Setup Multipurpose Input/Output pins.
> -        */
> -       if (idx == 0) {
> -               writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
> -               writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> -               writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> -               writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> -               writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> -               writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> -               writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
> -               writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
> -               writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
> -               writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
> -               writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
> -               writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
> -       }
> -       writeb(0x00, p + UART_EXAR_8XMODE);
> -       writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> -       writeb(128, p + UART_EXAR_TXTRG);
> -       writeb(128, p + UART_EXAR_RXTRG);
> -       iounmap(p);
> -
> -       return pci_default_setup(priv, board, port, idx);
> -}
> -
>  #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
>  #define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
>  #define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a
> @@ -1809,9 +1741,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
>  #define PCI_VENDOR_ID_AGESTAR          0x5372
>  #define PCI_DEVICE_ID_AGESTAR_9375     0x6872
>  #define PCI_VENDOR_ID_ASIX             0x9710
> -#define PCI_DEVICE_ID_COMMTECH_4224PCIE        0x0020
> -#define PCI_DEVICE_ID_COMMTECH_4228PCIE        0x0021
> -#define PCI_DEVICE_ID_COMMTECH_4222PCIE        0x0022
>  #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
>  #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
>
> @@ -2273,65 +2202,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
>                 .setup          = pci_timedia_setup,
>         },
>         /*
> -        * Exar cards
> -        */
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17C152,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17c154_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17C154,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17c154_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17C158,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17c154_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17V352,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17V354,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17V358,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17V4358,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_EXAR,
> -               .device = PCI_DEVICE_ID_EXAR_XR17V8358,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       /*
>          * Xircom cards
>          */
>         {
> @@ -2587,27 +2457,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
>                 .subdevice      = PCI_ANY_ID,
>                 .setup          = pci_fastcom335_setup,
>         },
> -       {
> -               .vendor = PCI_VENDOR_ID_COMMTECH,
> -               .device = PCI_DEVICE_ID_COMMTECH_4222PCIE,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_COMMTECH,
> -               .device = PCI_DEVICE_ID_COMMTECH_4224PCIE,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
> -       {
> -               .vendor = PCI_VENDOR_ID_COMMTECH,
> -               .device = PCI_DEVICE_ID_COMMTECH_4228PCIE,
> -               .subvendor      = PCI_ANY_ID,
> -               .subdevice      = PCI_ANY_ID,
> -               .setup          = pci_xr17v35x_setup,
> -       },
>         /*
>          * Broadcom TruManage (NetXtreme)
>          */
> @@ -2820,15 +2669,6 @@ enum pci_board_num_t {
>         pbn_computone_6,
>         pbn_computone_8,
>         pbn_sbsxrsio,
> -       pbn_exar_XR17C152,
> -       pbn_exar_XR17C154,
> -       pbn_exar_XR17C158,
> -       pbn_exar_XR17V352,
> -       pbn_exar_XR17V354,
> -       pbn_exar_XR17V358,
> -       pbn_exar_XR17V4358,
> -       pbn_exar_XR17V8358,
> -       pbn_exar_ibm_saturn,
>         pbn_pasemi_1682M,
>         pbn_ni8430_2,
>         pbn_ni8430_4,
> @@ -3469,76 +3309,6 @@ enum pci_board_num_t {
>                 .reg_shift      = 4,
>         },
>         /*
> -        * Exar Corp. XR17C15[248] Dual/Quad/Octal UART
> -        *  Only basic 16550A support.
> -        *  XR17C15[24] are not tested, but they should work.
> -        */
> -       [pbn_exar_XR17C152] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 2,
> -               .base_baud      = 921600,
> -               .uart_offset    = 0x200,
> -       },
> -       [pbn_exar_XR17C154] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 4,
> -               .base_baud      = 921600,
> -               .uart_offset    = 0x200,
> -       },
> -       [pbn_exar_XR17C158] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 8,
> -               .base_baud      = 921600,
> -               .uart_offset    = 0x200,
> -       },
> -       [pbn_exar_XR17V352] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 2,
> -               .base_baud      = 7812500,
> -               .uart_offset    = 0x400,
> -               .reg_shift      = 0,
> -               .first_offset   = 0,
> -       },
> -       [pbn_exar_XR17V354] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 4,
> -               .base_baud      = 7812500,
> -               .uart_offset    = 0x400,
> -               .reg_shift      = 0,
> -               .first_offset   = 0,
> -       },
> -       [pbn_exar_XR17V358] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 8,
> -               .base_baud      = 7812500,
> -               .uart_offset    = 0x400,
> -               .reg_shift      = 0,
> -               .first_offset   = 0,
> -       },
> -       [pbn_exar_XR17V4358] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 12,
> -               .base_baud      = 7812500,
> -               .uart_offset    = 0x400,
> -               .reg_shift      = 0,
> -               .first_offset   = 0,
> -       },
> -       [pbn_exar_XR17V8358] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 16,
> -               .base_baud      = 7812500,
> -               .uart_offset    = 0x400,
> -               .reg_shift      = 0,
> -               .first_offset   = 0,
> -       },
> -       [pbn_exar_ibm_saturn] = {
> -               .flags          = FL_BASE0,
> -               .num_ports      = 1,
> -               .base_baud      = 921600,
> -               .uart_offset    = 0x200,
> -       },
> -
> -       /*
>          * PA Semi PWRficient PA6T-1682M on-chip UART
>          */
>         [pbn_pasemi_1682M] = {
> @@ -3734,6 +3504,9 @@ enum pci_board_num_t {
>         { PCI_VDEVICE(INTEL, 0x228c), },
>         { PCI_VDEVICE(INTEL, 0x9ce3), },
>         { PCI_VDEVICE(INTEL, 0x9ce4), },
> +
> +       /* Exar devices */
> +       { PCI_VDEVICE(EXAR, PCI_ANY_ID), },
>  };
>
>  /*
> @@ -4159,58 +3932,6 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
>                 PCI_VENDOR_ID_AFAVLAB,
>                 PCI_SUBDEVICE_ID_AFAVLAB_P061, 0, 0,
>                 pbn_b0_4_1152000 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232, 0, 0,
> -               pbn_b0_2_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232, 0, 0,
> -               pbn_b0_4_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232, 0, 0,
> -               pbn_b0_8_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1, 0, 0,
> -               pbn_b0_2_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2, 0, 0,
> -               pbn_b0_4_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4, 0, 0,
> -               pbn_b0_8_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2, 0, 0,
> -               pbn_b0_2_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4, 0, 0,
> -               pbn_b0_4_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8, 0, 0,
> -               pbn_b0_8_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485, 0, 0,
> -               pbn_b0_2_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485, 0, 0,
> -               pbn_b0_4_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
> -               PCI_SUBVENDOR_ID_CONNECT_TECH,
> -               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485, 0, 0,
> -               pbn_b0_8_1843200_200 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
> -               PCI_VENDOR_ID_IBM, PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT,
> -               0, 0, pbn_exar_ibm_saturn },
> -
>         {       PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530,
>                 PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>                 pbn_b2_bt_1_115200 },
> @@ -4938,45 +4659,6 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
>         {       PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
>                 PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>                 pbn_b3_8_115200 },
> -
> -       /*
> -        * Exar Corp. XR17C15[248] Dual/Quad/Octal UART
> -        */
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17C152 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17C154 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17C158 },
> -       /*
> -        * Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs
> -        */
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V352,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V352 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V354,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V354 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V358,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V358 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V4358,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V4358 },
> -       {       PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V8358,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V8358 },
>         /*
>          * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
>          */
> @@ -5571,18 +5253,6 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
>                 PCI_ANY_ID, PCI_ANY_ID,
>                 0,
>                 0, pbn_b0_8_1152000_200 },
> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCIE,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V352 },
> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCIE,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V354 },
> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4228PCIE,
> -               PCI_ANY_ID, PCI_ANY_ID,
> -               0,
> -               0, pbn_exar_XR17V358 },
>
>         /* Fintek PCI serial cards */
>         { PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 9e1f7bf..0d20985 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -130,6 +130,7 @@ config SERIAL_8250_PCI
>  config SERIAL_8250_EXAR
>          tristate "8250/16550 PCI device support"
>          depends on SERIAL_8250_PCI
> +       default SERIAL_8250
>
>  config SERIAL_8250_HP300
>         tristate
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
