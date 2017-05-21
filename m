From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: gpio-exar: Why filtering out Commtech devices?
Date: Sun, 21 May 2017 21:08:41 +0100
Message-ID: <7a25751e-931f-b713-dcdd-7a7483aae115@codethink.co.uk>
References: <18f4b5cb-cba0-aab4-7958-84a5b8d28935@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <18f4b5cb-cba0-aab4-7958-84a5b8d28935@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Matt Schulte <matts@commtech-fastcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Jan,

On 21/05/17 12:46, Jan Kiszka wrote:
> Hi Sudip,
>
> why do we carry
>
> 	if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
> 		return -ENODEV;
>
> in gpio_exar_probe? This effectively prevents that
>
> 	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V35x),
> 	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V35x),
> 	EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V35x),
>
> gain GPIO support. Do those devices lack access to the pins? Or can we
> drop the filter. I don't have access to those devices, just wondering
> because the code is not explaining the reason.

Same here. I do not have these devices and have no idea if they support 
the gpio pins or not.

Adding Matt Schulte in the Cc list, maybe he can comment.


-- 
Regards
Sudip
