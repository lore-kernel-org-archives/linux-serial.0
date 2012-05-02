From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: 3.4-rc5: usbserial pl2303 attached via Texas Instruments USB3.0
 chip Oopses
Date: Wed, 02 May 2012 12:21:58 +0200
Message-ID: <4FA10AC6.8030809@fold.natur.cuni.cz>
References: <4FA10506.7020203@fold.natur.cuni.cz> <201205021208.47420.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:59639 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751864Ab2EBKWB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 May 2012 06:22:01 -0400
In-Reply-To: <201205021208.47420.oneukum@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org



Oliver Neukum wrote:
> Am Mittwoch, 2. Mai 2012, 11:57:26 schrieb Martin Mokrejs:
>> Hi,
>>   I am trying to setup a remote serial console on my Dell Vostro 3550 laptop.
>> I have some USB to serial dongle which has Prolific 2303 chipset, and works.
>> I have statically in my kernel:
>>
>> USB_SERIAL=y
>> USB_SERIAL_CONSOLE=y
>> CONFIG_USB_SERIAL_PL2303=y
>>
>>   The problem is that when I attach the dongle to USB3.0 controller linux crashes.
>> It does not happen if I attach it to EHCI controller (like shown in lsub output at
>> the end of this email).
> 
> Hi,
> 
> interesting. There's no good reason scheduling a work should fail
> depending on the hardware at this point. What does /proc/interrupts say?

When the dongle is connected via the EHCI controller, it says:

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       
  0:         25          0          0          0  IR-IO-APIC-edge      timer
  1:        682          0          0          0  IR-IO-APIC-edge      i8042
  8:         50          0          0          0  IR-IO-APIC-edge      rtc0
  9:          0          0          0          0  IR-IO-APIC-fasteoi   acpi
 12:        241          0          0          0  IR-IO-APIC-edge      i8042
 16:      42804          0          0          0  IR-IO-APIC-fasteoi   ehci_hcd:usb1
 23:        367          0          0          0  IR-IO-APIC-fasteoi   ehci_hcd:usb2
 40:          0          0          0          0  DMAR_MSI-edge      dmar0
 41:          0          0          0          0  DMAR_MSI-edge      dmar1
 42:          0          0          0          0  IR-PCI-MSI-edge      pciehp
 43:     192073          0          0          0  IR-PCI-MSI-edge      i915
 44:      19744          0          0          0  IR-PCI-MSI-edge      ahci
 45:      21862          0          0          0  IR-PCI-MSI-edge      eth0
 46:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
 47:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
 48:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
 49:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
 50:          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
 51:         14          0          0          0  IR-PCI-MSI-edge      mei
 52:        889          0          0          0  IR-PCI-MSI-edge      snd_hda_intel
 53:          6          0          0          0  IR-PCI-MSI-edge      iwlwifi
NMI:        104         65         62         87   Non-maskable interrupts
LOC:      43763      22386      26368      21843   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:        104         65         62         87   Performance monitoring interrupts
IWI:          0          0          0          0   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:       9763       5079        863        510   Rescheduling interrupts
CAL:        106        136        130        116   Function call interrupts
TLB:       1246        770       2069       2017   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:         13         13         13         13   Machine check polls
ERR:          0
MIS:          0
#

If you wanted me to reboot without the dongle inserted and plug it into the USB3.0
socket after bootup and provide lsusb -vvxx and /proc/interrupts, please let me know. ;-)

Martin
