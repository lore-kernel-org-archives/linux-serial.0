From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: gpio-exar: Why filtering out Commtech devices?
Date: Mon, 22 May 2017 18:24:33 +0200
Message-ID: <b725379e-fc67-d706-e172-ca585c3f5e3d@siemens.com>
References: <18f4b5cb-cba0-aab4-7958-84a5b8d28935@siemens.com>
 <7a25751e-931f-b713-dcdd-7a7483aae115@codethink.co.uk>
 <c7b03839-c2ab-fa3e-3af6-5d4678fa3bbd@siemens.com>
 <fc74be3d-7f74-cec3-769e-5eb53b2556b3@siemens.com>
 <CAPpjZG9MGDzS0Bu2c6M-Pob5JkzeAptDu8QNnDJETinCenee0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPpjZG9MGDzS0Bu2c6M-Pob5JkzeAptDu8QNnDJETinCenee0w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Technical Support <techsupport@commtech-fastcom.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-05-22 17:17, Technical Support wrote:
> Hello,
> 
> The Exar MPIO pins are used by our device driver to control features of
> the line driver and can't be used as GPIO pins.  I agree, the condition
> can be moved to 8250_exar prior to a platform device being created for
> the gpio_exar driver.
> 

Thanks a lot for the feedback! I will send a refactoring patch.

Jan

> Regards,
> Landon Unruh       
> 
> Commtech, Inc.
> Voice: 316-636-1131
> http://www.fastcomproducts.com
> 
> 
> 
> 
> On Mon, May 22, 2017 at 12:51 AM, Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 2017-05-22 07:48, Jan Kiszka wrote:
>     > On 2017-05-21 22:08, Sudip Mukherjee wrote:
>     >> Hi Jan,
>     >>
>     >> On 21/05/17 12:46, Jan Kiszka wrote:
>     >>> Hi Sudip,
>     >>>
>     >>> why do we carry
>     >>>
>     >>>     if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
>     >>>         return -ENODEV;
>     >>>
>     >>> in gpio_exar_probe? This effectively prevents that
>     >>>
>     >>>     EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V35x),
>     >>>     EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V35x),
>     >>>     EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V35x),
>     >>>
>     >>> gain GPIO support. Do those devices lack access to the pins? Or can we
>     >>> drop the filter. I don't have access to those devices, just wondering
>     >>> because the code is not explaining the reason.
>     >>
>     >> Same here. I do not have these devices and have no idea if they support
>     >> the gpio pins or not.
>     >>
>     >> Adding Matt Schulte in the Cc list, maybe he can comment.
>     >>
>     >>
>     >
>     > If we need to keep the condition, it should be moved over to 8250_exar:
>     > there is no point in creating the platform device at all then. But let's
>     > wait for Matt's comment.
> 
>     Unfortunately, his account is no longer existing. Is there anyone else
>     we can ask?
> 
>     Jan
> 
>     --
>     Siemens AG, Corporate Technology, CT RDA ITP SES-DE
>     Corporate Competence Center Embedded Linux
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-serial" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
> 
> 
