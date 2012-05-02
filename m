From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: 3.4-rc5: usbserial pl2303 attached via Texas Instruments USB3.0 chip Oopses
Date: Wed, 2 May 2012 12:22:30 +0200
Message-ID: <201205021222.30133.oneukum@suse.de>
References: <4FA10506.7020203@fold.natur.cuni.cz> <201205021208.47420.oneukum@suse.de> <4FA10AC6.8030809@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA10AC6.8030809-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Am Mittwoch, 2. Mai 2012, 12:21:58 schrieb Martin Mokrejs:
> 
> Oliver Neukum wrote:

> > interesting. There's no good reason scheduling a work should fail
> > depending on the hardware at this point. What does /proc/interrupts say?
> 
> When the dongle is connected via the EHCI controller, it says:
> 
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       
>   0:         25          0          0          0  IR-IO-APIC-edge      timer
>   1:        682          0          0          0  IR-IO-APIC-edge      i8042
>   8:         50          0          0          0  IR-IO-APIC-edge      rtc0
>   9:          0          0          0          0  IR-IO-APIC-fasteoi   acpi
>  12:        241          0          0          0  IR-IO-APIC-edge      i8042
>  16:      42804          0          0          0  IR-IO-APIC-fasteoi   ehci_hcd:usb1
>  23:        367          0          0          0  IR-IO-APIC-fasteoi   ehci_hcd:usb2
>  40:          0          0          0          0  DMAR_MSI-edge      dmar0
>  41:          0          0          0          0  DMAR_MSI-edge      dmar1
>  42:          0          0          0          0  IR-PCI-MSI-edge      pciehp
>  43:     192073          0          0          0  IR-PCI-MSI-edge      i915
>  44:      19744          0          0          0  IR-PCI-MSI-edge      ahci
>  45:      21862          0          0          0  IR-PCI-MSI-edge      eth0
>  46:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
>  47:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
>  48:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
>  49:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
>  50:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
>  51:         14          0          0          0  IR-PCI-MSI-edge      mei
>  52:        889          0          0          0  IR-PCI-MSI-edge      snd_hda_intel
>  53:          6          0          0          0  IR-PCI-MSI-edge      iwlwifi
> NMI:        104         65         62         87   Non-maskable interrupts
> LOC:      43763      22386      26368      21843   Local timer interrupts
> SPU:          0          0          0          0   Spurious interrupts
> PMI:        104         65         62         87   Performance monitoring interrupts
> IWI:          0          0          0          0   IRQ work interrupts
> RTR:          0          0          0          0   APIC ICR read retries
> RES:       9763       5079        863        510   Rescheduling interrupts
> CAL:        106        136        130        116   Function call interrupts
> TLB:       1246        770       2069       2017   TLB shootdowns
> TRM:          0          0          0          0   Thermal event interrupts
> THR:          0          0          0          0   Threshold APIC interrupts
> MCE:          0          0          0          0   Machine check exceptions
> MCP:         13         13         13         13   Machine check polls
> ERR:          0
> MIS:          0
> #
> 
> If you wanted me to reboot without the dongle inserted and plug it into the USB3.0
> socket after bootup and provide lsusb -vvxx and /proc/interrupts, please let me know. ;-)

There's on obvious difference that might be worth checking out.
Does it work if you boot with nomsi?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
