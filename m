From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] pch_uart: Add MSI support
Date: Thu, 23 Jun 2011 09:16:38 +0200
Message-ID: <4E02E856.70007@ladisch.de>
References: <4E02857C.1010304@dsn.okisemi.com> <1308812405-5245-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308812405-5245-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Alexander Stein wrote:
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -1578,6 +1578,8 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
>  
> +	pci_enable_msi(pdev);

Pretty much every driver that tries this eventually ends up with
a blacklist of devices that don't implement MSI correctly.
Did you test this with all the models that are supported by this driver?


Regards,
Clemens
