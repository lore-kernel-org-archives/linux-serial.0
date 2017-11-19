From: Matt Wilson <msw@amzn.com>
Subject: Re: [PATCH v2] serial: 8250_pci: Add Amazon PCI serial device ID
Date: Sat, 18 Nov 2017 20:26:07 -0800
Message-ID: <20171119042607.GA26232@ued668862963453.ant.amazon.com>
References: <20171113083111.GB22719@kroah.com>
 <1510601491-31803-1-git-send-email-msw@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510601491-31803-1-git-send-email-msw@linux.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 13, 2017 at 11:31:31AM -0800, Matt Wilson wrote:
> From: Matt Wilson <msw@amazon.com>
> 
> This device will be used in future Amazon EC2 instances as the primary
> serial port (i.e., data sent to this port will be available via the
> GetConsoleOuput [1] EC2 API).

Ping?

--msw

> [1] http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetConsoleOutput.html
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Wilson <msw@amazon.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 0c101a7..d4e7be8 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5137,6 +5137,9 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  	{ PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000 },
>  	{ PCI_DEVICE(0x1601, 0xa801), .driver_data = pbn_b0_4_1250000 },
>  
> +	/* Amazon PCI serial device */
> +	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200 },
> +
>  	/*
>  	 * These entries match devices with class COMMUNICATION_SERIAL,
>  	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
