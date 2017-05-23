From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: gpio-exar: Why filtering out Commtech devices?
Date: Tue, 23 May 2017 17:05:34 +0200
Message-ID: <2445db07-a150-e954-099c-f39faefeb4b5@siemens.com>
References: <18f4b5cb-cba0-aab4-7958-84a5b8d28935@siemens.com>
 <7a25751e-931f-b713-dcdd-7a7483aae115@codethink.co.uk>
 <c7b03839-c2ab-fa3e-3af6-5d4678fa3bbd@siemens.com>
 <fc74be3d-7f74-cec3-769e-5eb53b2556b3@siemens.com>
 <CAPpjZG9MGDzS0Bu2c6M-Pob5JkzeAptDu8QNnDJETinCenee0w@mail.gmail.com>
 <b725379e-fc67-d706-e172-ca585c3f5e3d@siemens.com>
 <6ac3fff4-5d23-d30c-1e04-e5a1f12f466d@siemens.com>
 <CAPpjZG_HPFqKzf+7rBxM27TJcZJ4+vfUYSPChifM-JTN7ekTOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPpjZG_HPFqKzf+7rBxM27TJcZJ4+vfUYSPChifM-JTN7ekTOA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Technical Support <techsupport@commtech-fastcom.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-05-23 16:33, Technical Support wrote:
> Both the PCI and the PCIe cards use the MPIO pins and the device driver
> actually sets the pins as outputs after registering the device with the
> PCI core.  So the changes made to the default settings shouldn't break
> anything. 
> 
> Do the new default settings keep the UART_EXAR_MPIOINT_X_X values at
> 0x00 to disable their interrupts? 

Look at
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=7dea8165f1d6434dc7572004363f86339f0f4322

Interrupts remain off, but all pins are now inputs. Again, if the logic
on the PCIe cards need any of them to be driven low, my patch causes a
regression. In that case, we also need to make the MPIO setup card-specific.

Thanks,
Jan

> 
> -Landon 
>         
> Commtech, Inc.
> Voice: 316-636-1131 <tel:%28316%29%20636-1131>
> http://www.fastcomproducts.com
> 
> 
> 
> 
> On Mon, May 22, 2017 at 1:18 PM, Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 2017-05-22 18:24, Jan Kiszka wrote:
>     > On 2017-05-22 17:17, Technical Support wrote:
>     >> Hello,
>     >>
>     >> The Exar MPIO pins are used by our device driver to control features of
>     >> the line driver and can't be used as GPIO pins.  I agree, the condition
>     >> can be moved to 8250_exar prior to a platform device being created for
>     >> the gpio_exar driver.
>     >>
>     >
>     > Thanks a lot for the feedback! I will send a refactoring patch.
> 
>     Hmm, are you possibly talking about PCI device with the IDs 0x2, 0x4,
>     0xa, 0xb (4222PCI335, 4224PCI335, 2324PCI335, 2328PCI335), because those
>     actually set the GPIOs for apparent internal reasons. However,
>     0x20..0x22 (4222PCIE, 4224PCIE, 4228PCIE) already share setup_gpio() via
>     pci_xr17v35x_setup(), and that looks different.
> 
>     I'm also asking again because we just changed the default MPIO settings
>     for the latter to all inputs. If you depended on them to be all outputs
>     and 0, we may have broken something.
> 
>     Thanks,
>     Jan
> 
>     --
>     Siemens AG, Corporate Technology, CT RDA ITP SES-DE
>     Corporate Competence Center Embedded Linux
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
