From: Jonathan Woithe <jwoithe@just42.net>
Subject: Comments requested: driver for Quatech PCI serial cards
Date: Wed, 14 Nov 2012 16:37:24 +1030
Message-ID: <20121114060724.GN30156@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:51742 "EHLO
	server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2KNGZO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 01:25:14 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: jwoithe@just42.net

Quatech (now B&B Electronics) make a range of multiport PCI serial cards for
RS232 and RS422 connectivity.  A GPL Linux driver is available on the
Quatech web site (http://www.quatech.com/support/drivers_pci.php) but as far
as I can tell no attempt has been made to mainline it.  The driver's
maintenance by Quatech appears to have ceased in 2007 and as a result, the
driver they provide no longer compiles against mainline.

The driver supports a wide range of Quatech DSC/ESC/QSC cards, including the
custom functionality which allow various aspects of the signal routing to be
altered under software control.

I have ported the driver to compile again (most recent kernel tested is
currently 3.4.4).  I've also cleaned up some formatting issues, removed the
most obvious redundant code and fixed a few bugs I discovered along the way. 
The result consists of two files which I have included at the end of this
message.

I am fully aware that there are still a bunch of things which need to be
done before this can be considered for mainline: things like the
module/filename naming convention for starters.  What I would like to
determine is how much extra work would be required before this module could
be considered for mainline.  While I do not have the time or resources to
embark on a full rewrite, I am very willing to address stylistic issues or
minor quibbles with the code.

Things I know will need addressing:
 - debug / printk usage
 - indenting convention
 - naming conventions, especially of internal structures
 - the name of the module.  Anything with "qt" in it will confuse people.
   I'm thinking along the lines of serial-quatech or quatech-serial:
   comments welcome.

Things I've currently only guessed (and which therefore could be completely
off-beam):
 - the compat_ioctl stuff
 - locking requirements within the ioctl handler

One issue which might raise eyebrows is the use of some new ioctls.  I'm
guessing that ideally this sort of thing would be done either via sysfs or
procfs now.  The problem is that Quatech supply some binary applications to
manipulate various non-standard features of these cards, and they expect
ioctls.  While all the information required to write replacements which use
a more acceptable interface is available in the driver source, I would
prefer to defer this until later if at all possible.

I would appreciate comments in relation to this driver so I can determine
whether or not it's feasible for me to get it into shape for formal
mainline submission.

Regards
  jonathan

----

SerQT_PCI.c

/*
 * Driver for Quatech PCI serial cards
 *
 * Copyright (C) 2004, 2005, 2007 Tim Gobeli <tgobeli@quatech.com>
 * Copyright (C) 2012 Jonathan Woithe <jwoithe@just42.net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <linux/version.h>
#include <linux/module.h>
#include "serialqt_pci.h"

// Uncomment for debugging
//#define DEBUG_ON

#ifdef DEBUG_ON
    #define  dbgprint(const...)    printk(const)

#else
    #define  dbgprint(const...)
#endif

MODULE_AUTHOR("Tim Gobeli <tgobeli@quatech.com>");
MODULE_DESCRIPTION("Driver for PCI Quatech serial port adapters, v1.28");
MODULE_LICENSE("GPL");

static struct pci_dev_link_t *pPci_portlist = NULL;
static int major_number;

static long int ioctl_serial_pci (struct file *filp, unsigned int cmd,
                                     unsigned long arg);

#ifdef CONFIG_COMPAT
static long int compat_ioctl_serial_pci (struct file *filp, unsigned int cmd,
                                       unsigned long arg);
#endif

static void multi_config(struct pci_dev *pDev, multi_id_t multi_info, int index);

static unsigned SerialReadQOPR_Reg(unsigned Base_Address);

static void SerialWriteQOPR_Reg(unsigned Base_Address, bool internal, unsigned Arg);

static void SerialWriteQMCR_Reg(unsigned Base_Address, unsigned Arg);

static unsigned SerialReadQMCR_Reg(unsigned Base_Address);

static int SerialDoes422_Exist(unsigned Base_Address);

static int SerialDoesQMCR_Exist(unsigned Base_Address);

static bool SerialLockOutOverride(unsigned Base_Address);

static bool SerialClkCtrlOverride(unsigned Base_Address, unsigned long *pClock_Rate);

struct file_operations serialqt_pci_fops = {
    unlocked_ioctl:  ioctl_serial_pci,
#ifdef CONFIG_COMPAT
    compat_ioctl:    compat_ioctl_serial_pci,
#endif

};


long int ioctl_serial_pci (struct file *filp, unsigned int cmd, 
                              unsigned long arg)
{
    unsigned long irqflags;
    unsigned ud_QT_Baseaddress, err;
    unsigned ucOPR_OrgValue, ucOPR_NewValue, uc_Value;
    int *p_Num_of_adapters, counts, index, *p_QMCR_Value;
    struct pci_dev *dev = NULL;
    Identity_struct *p_Identity_of;
    Identity_struct  Identity_of;

    struct pci_dev_link_t *pTemp_dev_link ;
    dbgprint(KERN_DEBUG"ioctl_serial_pci  cmd =\n");
     if (_IOC_TYPE(cmd) != SERIALQT_PCI_IOC_MAGIC)
        return -ENOTTY;
    if (_IOC_NR(cmd) > SERIALQT_IOC_MAXNR)
        return -ENOTTY;
    dbgprint(KERN_DEBUG"ioctl_serial_pci  cmd = 0x%x\n", cmd);
        err = 0;

    switch (cmd)
    {
    case SERIALQT_WRITE_QOPR: 
        pTemp_dev_link = pPci_portlist;
        index = arg >> 16;
        counts = 0;
        // Go through the whole list and find the  adapter
        while (pTemp_dev_link)
        {
            dbgprint(KERN_DEBUG"ioctl_serial_pci  arg = 0x%lx\n", arg);
            // Setting one port QOPR on multiport adapter sets them all  
            if (pTemp_dev_link->Adapter_Index == index)
            {
                // We've found the adapter we want, lets change the QOPR time 
                // setting accordingly
                spin_lock_irqsave(pTemp_dev_link->lock, irqflags);
                ud_QT_Baseaddress = pTemp_dev_link->ulPortStart;
                ucOPR_OrgValue =  SerialReadQOPR_Reg(ud_QT_Baseaddress);
                // Just mask off the last two bits of the QOPR register 
                // because thats all that needs changed there for clock 
                // rate control
                ucOPR_NewValue = ucOPR_OrgValue & 0xfc;
                ucOPR_NewValue = ucOPR_NewValue | arg;
                SerialWriteQOPR_Reg(ud_QT_Baseaddress, FALSE, ucOPR_NewValue);
                // We're done
                spin_unlock_irqrestore(pTemp_dev_link->lock, irqflags);
                break;
            } else
            {
                pTemp_dev_link = pTemp_dev_link->next;
            }

        }  // end while
        break;

    case SERIALQT_WRITE_QMCR:
        // initialize as error so if we don't find this one we give
        err = -ENOTTY; 
        pTemp_dev_link = pPci_portlist;
        index = arg >> 16;

        // Go through the whole list and find the  adapter
        while (pTemp_dev_link != NULL)
        {
            dbgprint(KERN_DEBUG"ioctl_serial_pci  arg = 0x%lx\n", arg);
            if (pTemp_dev_link->Adapter_Index == index)
            {
                // must set each ports QMCR individually
                while ((pTemp_dev_link != NULL) && 
                       (pTemp_dev_link->Adapter_Index == index))
                {
                    spin_lock_irqsave(pTemp_dev_link->lock, irqflags);
                    // We've found the adapter we want, lets change the 
                    // QMCR time setting accordingly
                    ud_QT_Baseaddress = pTemp_dev_link->ulPortStart;
                    ucOPR_NewValue = arg;

                    dbgprint(KERN_DEBUG"ioctl SERIALQT_WRITE_QMCR:  Base Addrss = 0x%x,  value = 0x%x\n", ud_QT_Baseaddress, ucOPR_NewValue);
                    SerialWriteQMCR_Reg(ud_QT_Baseaddress, ucOPR_NewValue );
                    err = 0;
                    spin_unlock_irqrestore(pTemp_dev_link->lock, irqflags);
                    pTemp_dev_link = pTemp_dev_link->next;
                }
                // We're done
                break;
            } else
            {
                pTemp_dev_link = pTemp_dev_link->next;
            }
        }  // end while
        break;

    case SERIALQT_READ_QMCR:
        // initialize as error so if we don't find this one we give an error.
        err = -ENOTTY;
        p_QMCR_Value =  (int *)arg;
        pTemp_dev_link = pPci_portlist;
        index = arg >> 16;
        counts = 0;
        while (pTemp_dev_link != NULL)
        {
            if (pTemp_dev_link->Adapter_Index == index)
            {
                spin_lock_irqsave(pTemp_dev_link->lock, irqflags);
                ud_QT_Baseaddress = pTemp_dev_link->ulPortStart;
                uc_Value =  SerialReadQMCR_Reg(ud_QT_Baseaddress);
                err = put_user(uc_Value, p_QMCR_Value);
                spin_unlock_irqrestore(pTemp_dev_link->lock, irqflags);
                break;   // We're done
            } else
            {
                pTemp_dev_link = pTemp_dev_link->next;
            }
        }
        break;

    case SERIALQT_GET_NUMOF_UNITS: 
        p_Num_of_adapters = (int *)arg;
        counts = 0;
        dbgprint(KERN_DEBUG"SERIALQT_GET_NUMOF_UNITS \n");

        for (index = 0; index < (sizeof(multi_id)/sizeof( multi_id_t)); index++)
        {
            dev = pci_get_subsys(QUATECH_VID, multi_id[index].prodid, 
                                    PCI_ANY_ID, PCI_ANY_ID, NULL);
            while (dev != NULL) // find multiple devices of same signature
            {
                counts++;
                dev = pci_get_subsys(QUATECH_VID, multi_id[index].prodid, 
                                        PCI_ANY_ID, PCI_ANY_ID, dev);
            }
        }
        dbgprint(KERN_DEBUG"ioctl_serial_pci writting counts = %d", counts);
        err = put_user(counts, p_Num_of_adapters);
        break;

    case SERIALQT_GET_THIS_UNIT:
        counts = 0;
        p_Identity_of = (Identity_struct *)arg;
        // copy user structure to local variable

        get_user(Identity_of.index, &p_Identity_of->index);
        dbgprint(KERN_DEBUG"SERIALQT_GET_THIS_UNIT Identity_of.index= 0x%x\n", Identity_of.index);

        // initialize as error so if we don't find this one we give an error.
        err = -ENOTTY; 

        pTemp_dev_link = pPci_portlist;
        while (pTemp_dev_link != NULL)
        {
            if (pTemp_dev_link->Adapter_Index == Identity_of.index)
            {
                err = put_user(pTemp_dev_link->prodid, &p_Identity_of->n_identity);
                break;   // We're done

            } else
            {
                pTemp_dev_link = pTemp_dev_link->next;
            }
        }
        break;

    case SERIALQT_IS422_EXTENDED:
        err = -ENOTTY; // initialize as error so if we don't find this one we give
        dbgprint(KERN_DEBUG"SERIALQT_IS422_EXTENDED \n");
        pTemp_dev_link = pPci_portlist;
        index = arg >> 16;

        while (pTemp_dev_link != NULL)
        {
            if (pTemp_dev_link->Adapter_Index == index)
            {
                dbgprint(KERN_DEBUG"Found Adapter \n");

                ud_QT_Baseaddress = pTemp_dev_link->ulPortStart;
                if (SerialDoesQMCR_Exist(ud_QT_Baseaddress))
                {
                    err = 1;
                    break;   // no MCR so return -ENOTTY;
                }
                if (SerialDoes422_Exist(ud_QT_Baseaddress))
                {
                    err = 2;
                    break;
                }
                dbgprint(KERN_DEBUG"SERIALQT_IS422_EXTENDED err = 0\n");

                // If we got this far then it is a 422/485 extended feature 
                // device
                err = 0; 
                break; 
            } else
            {
                pTemp_dev_link = pTemp_dev_link->next;
            }
        }
        break;

    default:
        err = -ENOTTY;

    } // End switch

    return err;
}

#ifdef CONFIG_COMPAT
long int compat_ioctl_serial_pci (struct file *filp, unsigned int cmd,
                                     unsigned long arg)
{
    long int err = 0;
    unsigned long compat_arg = 0;
    switch (cmd)
    {
    case SERIALQT_WRITE_QOPR: 
    case SERIALQT_WRITE_QMCR:
    case SERIALQT_IS422_EXTENDED:
        /* arg is an integer value */
        compat_arg = arg;
        break;
    case SERIALQT_READ_QMCR:
    case SERIALQT_GET_NUMOF_UNITS:
    case SERIALQT_GET_THIS_UNIT:
        /* arg is a pointer */
        compat_arg = (unsigned long)compat_ptr(arg);
        break;
    default:
        err = -ENOTTY;
    }
    if (err == 0)
        err = ioctl_serial_pci(filp, cmd, compat_arg);

    return err;
}
#endif

void SerialWriteQOPR_Reg(unsigned Base_Address, bool internal, unsigned Arg)
{
    unsigned    ulQT_ORaddress, ulQT_LCRaddress;
    unsigned    ucLCR_OrgValue, ucOPR_OrgValue, ucOPR_NewValue;

    // We only allow the last two bits to change on the QOR register
    ulQT_ORaddress = Base_Address + 7;
    ulQT_LCRaddress = Base_Address + 3;
    // Set DLAB to access options register
    ucLCR_OrgValue = inb(ulQT_LCRaddress);
    dbgprint(KERN_DEBUG"Read LCR at = 0x%x value = 0x%x\n", ulQT_LCRaddress, ucLCR_OrgValue);

    outb(0xbf, ulQT_LCRaddress);
    dbgprint(KERN_DEBUG" Wrote LCR at = 0x%x value = 0x%x\n", ulQT_LCRaddress, 0xbf);

    ucOPR_OrgValue = inb(ulQT_ORaddress);
    // If this comes from user -Just mask off the last two bits of the QOPR register cause thats all 
    // that needs changed there for clock rate control
    if(internal == FALSE)
    {
         ucOPR_NewValue = ucOPR_OrgValue & 0xfc;
         ucOPR_NewValue = ucOPR_NewValue | Arg; 
         dbgprint(KERN_DEBUG"Read qopr at = 0x%x value = 0x%x\n", ulQT_ORaddress, ucOPR_OrgValue);
    }
    else
        ucOPR_NewValue = Arg;

    //Write new value to options register
    outb(ucOPR_NewValue, ulQT_ORaddress );

    dbgprint(KERN_DEBUG"SerialWriteQOPR_Reg: Wrote qopr at = 0x%x value = 0x%x\n", ulQT_ORaddress, ucOPR_NewValue);

    // Read the value back for testing purposes
    // ucLCR_OrgValue = 0;
    // ucLCR_OrgValue = inb(ulQT_ORaddress);
    // dbgprint(KERN_DEBUG"Read qopr at = 0x%x value = 0x%x", ulQT_ORaddress, ucLCR_OrgValue);

    // Restore origninal lCR value
    outb(ucLCR_OrgValue, ulQT_LCRaddress ); 
}

unsigned SerialReadQOPR_Reg(unsigned Base_Address)
{
    unsigned    ulQT_ORaddress, ulQT_LCRaddress;
    unsigned    ucLCR_OrgValue, ucOPR_Value;

    //We only allow the last two bits to change on the QOR register
    ulQT_ORaddress = Base_Address + 7;
    ulQT_LCRaddress = Base_Address + 3;
    // Set DLAB to access options register
    ucLCR_OrgValue = inb(ulQT_LCRaddress);

    outb(0xbf, ulQT_LCRaddress);
     ucOPR_Value = inb(ulQT_ORaddress);
    // Restore origninal lCR value
    outb(ucLCR_OrgValue, ulQT_LCRaddress ); 
    dbgprint(KERN_DEBUG" SerialReadQOPR_Reg:Read QOR at Base = 0x%x value = 0x%x\n", Base_Address, ucOPR_Value);

    return ucOPR_Value;  
}

void SerialWriteQMCR_Reg(unsigned Base_Address, unsigned Arg)
{
    unsigned    ulQT_ORaddress, ulQT_LCRaddress, ulQT_MCRaddress;
    unsigned    ucLCR_OrgValue, ucOPR_OrgValue;

    // We only allow the last two bits to change on the QOR register
    ulQT_ORaddress = Base_Address + 7;
    ulQT_LCRaddress = Base_Address + 3;
    ulQT_MCRaddress = Base_Address + 4;
    // Set DLAB to access options register
    ucLCR_OrgValue = inb(ulQT_LCRaddress);

    outb(0xbf, ulQT_LCRaddress);

    ucOPR_OrgValue = inb(ulQT_ORaddress);
    // Set options register QLAB bit to access QMCR register
    outb(ucOPR_OrgValue | 0x10, ulQT_ORaddress);
    // Now write to the QMCR register
    outb(Arg, ulQT_MCRaddress);

    // Restore original contents of QOPR register
    outb(ucLCR_OrgValue, ulQT_LCRaddress );

    // Restore origninal lCR value
    outb(ucLCR_OrgValue, ulQT_LCRaddress ); 
}

unsigned SerialReadQMCR_Reg(unsigned Base_Address){

    unsigned    ulQT_ORaddress, ulQT_LCRaddress, ulQT_MCRaddress;
    unsigned    ucLCR_OrgValue, ucOPR_OrgValue, ucMCR_Value;

    // We only allow the last two bits to change on the QOR register
    ulQT_ORaddress = Base_Address + 7;
    ulQT_LCRaddress = Base_Address + 3;
    ulQT_MCRaddress = Base_Address + 4;
    // Set DLAB to access options register
    ucLCR_OrgValue = inb(ulQT_LCRaddress);

    outb(0xbf, ulQT_LCRaddress);

    ucOPR_OrgValue = inb(ulQT_ORaddress);
    // Set options register QLAB bit to access QMCR register
    outb(ucOPR_OrgValue | 0x10, ulQT_ORaddress);
    // Now read the QMCR register
    ucMCR_Value = inb(ulQT_MCRaddress);

    // Restore original contents of QOPR register
    outb(ucOPR_OrgValue, ulQT_ORaddress );

    // Restore origninal lCR value
    outb(ucLCR_OrgValue, ulQT_LCRaddress ); 

    return ucMCR_Value;
}

// SerialDoesQMCR_Exist tests for existence of QMCR register and returns 0
// valueif it does and nonzero if it doesn't 
int SerialDoesQMCR_Exist(unsigned Base_Address)
{
    unsigned    ulQT_ORaddress, ulQT_LCRaddress, ulQT_MCRaddress;
    unsigned    ucLCR_OrgValue, uc_Value;
    int        Status = 0;

    // We only allow the last two bits to change on the QOR register
    ulQT_ORaddress = Base_Address + 7;
    ulQT_LCRaddress = Base_Address + 3;
    ulQT_MCRaddress = Base_Address + 4;
    // Set DLAB to access options register
    ucLCR_OrgValue = inb(ulQT_LCRaddress);
    // Writting a 0xbf to lcr will make bet 5 of QOR go high if QOR and QMCR exist
    outb(0xbf, ulQT_LCRaddress);
    uc_Value = inb(ulQT_ORaddress);
    if (!(uc_Value & 0x20))//Is bit 5 (IDX) set
    {
        dbgprint(KERN_DEBUG"QMCR bit b5 not set \n");
        Status = -ENOTTY;
    }

    if (Status == 0)
    {
        // So far so good now write something other than 0xbf to the LCR to set IDX to 0
        // and test
        outb(0x80, ulQT_LCRaddress);
        // IDX should be clear
        uc_Value = inb(ulQT_ORaddress);
        if (uc_Value & 0x20)
            Status = -ENOTTY;

    }
    outb(ucLCR_OrgValue, ulQT_LCRaddress); // Restore original value
    return Status;
}

int SerialDoes422_Exist(unsigned Base_Address)
{
    int Status;
    unsigned ucMCR_OrgValue, uc_Value;
    ucMCR_OrgValue = SerialReadQMCR_Reg(Base_Address);
    // Essentially we're ging to write a value of 0xff to the QMCR register and 
    // if we read back a nonzero value, then its a 422 device otherwize its 422
    uc_Value = 0xff;
    SerialWriteQMCR_Reg(Base_Address, uc_Value);
    uc_Value = 0;
    uc_Value = SerialReadQMCR_Reg(Base_Address);
    if (uc_Value)
        Status = 0;
    else
        Status = -ENOTTY;

    SerialWriteQMCR_Reg(Base_Address, ucMCR_OrgValue);

    return Status;
}

int init_serial_pci(void){

    struct pci_dev *dev;

    int index;
    int status = 0;
    int Adapter_Index = 0;

    dev = NULL;

    dbgprint(KERN_DEBUG"Entering SerialQT_PCI \n\n");

    // Find the given adapters and register them accordingly with the serial 
    // core
    for (index = 0; index < (sizeof(multi_id)/sizeof( multi_id_t)); index++)
    {
        dev = pci_get_subsys(QUATECH_VID, multi_id[index].prodid, PCI_ANY_ID, 
                                PCI_ANY_ID, NULL);
        if (dev != NULL)
        {
            while (dev != NULL) // find multiple devices of same signature
            {
                status++;
                status = pci_enable_device(dev);
                if(status < 0)
                {
                    dbgprint(KERN_DEBUG"SerialQT_PCI - Unable to enable device \n\n");
                    return -EBUSY;
                }
                multi_config(dev, multi_id[index], Adapter_Index);
                Adapter_Index++; // index for next one
                dev = pci_get_subsys(QUATECH_VID, multi_id[index].prodid, 
                                        PCI_ANY_ID, PCI_ANY_ID, dev);
            }
        }
    }

    if (Adapter_Index == 0)
        dbgprint(KERN_DEBUG"No devices found \n\n");

    status = 0; // Dynamic assignment of major number
    major_number = register_chrdev(status, "SerialQT_PCI", &serialqt_pci_fops);
    if (major_number < 0)
    {
        dbgprint(KERN_DEBUG"No devices found \n\n");
        return -EBUSY;
    } else
       dbgprint(KERN_DEBUG"SerQT_PCI major number assignment = %d \n\n", major_number);
    return 0;
}

// multi_config()
// Inputs:
//  * Struct pci_dev * passed from successful pci_get_subsys()
//  * multi_id_t structure of device found
//
// Description:
//   Determines resources used by an adapter and uses them to register the
//   ports.  It then saves pertinent information for each port in a linked 
//   list for later use to configure the adapter per users request.

static void multi_config(struct pci_dev *pDev, multi_id_t multi_info, int Adapter_Index){

    int index;
    unsigned int ulAddressStart, ulPortAddress;
    unsigned int Irq;
    int nFound = 0;
    struct pci_dev_link_t *pTemp_dev_link;
    #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
    struct uart_port serial;
    #else
    struct serial_struct serial;
    #endif
    int line;
    int nNum_of_Ports = multi_info.multi;
    unsigned long Clock_Rate;
    u32 tmp;
   
    Irq = pDev->irq;
    dbgprint(KERN_DEBUG"Device = 0x%x, Irq = %d\n", pDev->device, Irq);

    // Set byte in the Amcc dchiep in the extremly unlikely event that the
    // system bios didn't run the ROM bios extension on our pci card
    if(multi_info.AMCC == TRUE)
    {
        ulPortAddress = pci_resource_start(pDev, 0);
        ulAddressStart = ulPortAddress + 0x38;
        tmp = inl(ulAddressStart);
        tmp = tmp | 0x00002000;
        dbgprint(KERN_DEBUG"Bios work around, writing value = 0x%x Device = 0x%x, at 0x%x\n",tmp, pDev->device, ulAddressStart);

        outl(tmp, ulAddressStart);

        ulAddressStart = ulPortAddress + 0x3c;
		
        tmp = inl(ulAddressStart);
        tmp = tmp |  0x01000000;
        outl(tmp, ulAddressStart);
        tmp &= ~0x01000000;
        outl(tmp, ulAddressStart);
    }

    ulAddressStart = pci_resource_start(pDev, multi_info.IO_Region);

    dbgprint(KERN_DEBUG"Device = 0x%x, Address = 0x%x", pDev->device, ulAddressStart);

    // SerialClkCtrlOverride will set the adapter clock rate to highest
    // available rate and return that rate in the varible
    SerialClkCtrlOverride((unsigned)ulAddressStart, &Clock_Rate);

    if (ulAddressStart != 0)
        nFound = 1;
    else
        nFound = 0;

    if (nFound)
    {
        for (index = 0; index < nNum_of_Ports; index++)
        {
            ulPortAddress = ulAddressStart + (index * 8);
            memset(&serial, 0, sizeof(serial));
            serial.irq = Irq;
            #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
            serial.iobase = ulPortAddress;
            serial.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
            serial.uartclk = Clock_Rate;
            line = serial8250_register_port(&serial);
            #else
            serial.port = ulPortAddress;
            serial.flags = ASYNC_SKIP_TEST | ASYNC_SHARE_IRQ;
            serial.baud_base = Clock_Rate;
            line = register_serial(&serial);
            #endif
                       
            if (line < 0)
            {
                dbgprint(KERN_DEBUG"<1>SerQT_PCI:  register_serial() at 0x%04lx,irq %d failed\n",(u_long)ulPortAddress, serial.irq); 
                return;
            } else
            {
                dbgprint(KERN_DEBUG"SerQT_PCI:  register_serial() at 0x%04lx,irq %d, ttyS%d succeded\n",(u_long)ulPortAddress, serial.irq, line); 
            }
            pTemp_dev_link = kmalloc(sizeof(struct pci_dev_link_t), GFP_KERNEL);
            if (!pTemp_dev_link)
            {
                dbgprint(KERN_DEBUG"IN %s insufficient resources\n", __FUNCTION__);
                #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
                serial8250_unregister_port(line);
                #else
                unregister_serial(line);
                #endif
                
                return;
            } else
            {
                memset(pTemp_dev_link, 0, sizeof(struct pci_dev_link_t));
                serial.line = line;
            }
            // Create a list of ports with information we'll use to custom 
            // configure it
            pTemp_dev_link->line = serial.line;
            pTemp_dev_link->prodid =  multi_info.prodid;
            pTemp_dev_link->type = multi_info.type;
            pTemp_dev_link->Port_Number = index;
            pTemp_dev_link->ulPortStart = ulPortAddress;
            pTemp_dev_link->Adapter_Index = Adapter_Index;
            pTemp_dev_link->lock = &serial.lock;
            pTemp_dev_link->next = (void *)pPci_portlist;
            pPci_portlist = pTemp_dev_link;
        }   // end for
    } else
    {
        dbgprint(KERN_DEBUG"Couldn't find device\n");
    }// end if
}

// SerialClkCtrlOverride()
//
// Called from muli_config() to to determine if overrides to the Clock mode
// of the hardware feature have been set via jumper configurations
// also determines max clock multiplier and sets the adapter accordingly
// (some cards have a max multiplier of X4 some of X8
//
// Inputs: 
//  * Base_Address     Adapter base address
//
// Outputs: None
//
// Returns:
//  * True if no QOPR or locked out, also appropriate clocke rate is
//    returned in the pClock_Rate parameter

bool SerialClkCtrlOverride(unsigned Base_Address, unsigned long *pClock_Rate)
{
    unsigned QOPR_OrgValue, QOPR_Value, TestOutValue, Auto_QOPR_Setting;
    bool status;

    status =  SerialLockOutOverride(Base_Address);
    // If no QOR we disable all these selections
    if (status == TRUE)
    {
        dbgprint(KERN_DEBUG"SerialClkCrtlOverride, no QOR\n"); 

        *pClock_Rate =  CLOCK_X1; // No Qor so use standard rate and return
        return status;
    }

    QOPR_OrgValue = SerialReadQOPR_Reg(Base_Address);
    QOPR_Value = QOPR_OrgValue & (~QOPR_CLOCK_X8); // Clear clk rate bits

    SerialWriteQOPR_Reg(Base_Address, FALSE, QOPR_Value);

    TestOutValue = SerialReadQOPR_Reg(Base_Address);
    // Those bits shoud be 0, if not we're overridden
    if (TestOutValue &= QOPR_CLOCK_X8)
    {
        *pClock_Rate =  CLOCK_X1; // Set to standard rate if overridden
        status =  TRUE;
    }
    else
    {
        // Now try setting them to "1" and see if any of it sticks
        // some cards only go X4 so only hi bit sticks
        QOPR_Value = QOPR_Value | QOPR_CLOCK_X8; // Set clk rate bits


        SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_Value);

        TestOutValue = SerialReadQOPR_Reg(Base_Address);
        if (TestOutValue &=QOPR_CLOCK_X8)
            status =  FALSE;  // It stuck, we're not overridden
        else
        {
            *pClock_Rate =  CLOCK_X1; // Set to standard rate if overridden
            status =  TRUE; // It didn't stick, we are overridden
        }

    }

    // Ok were not forced but the max rate is not the same for all boards
    // lets find out what the max is and  
    if (status == FALSE)
    {
        TestOutValue = SerialReadQOPR_Reg(Base_Address);
        TestOutValue &=QOPR_CLOCK_X8;
        switch (TestOutValue)
        {
        case QOPR_CLOCK_X2:
            *pClock_Rate =  CLOCK_X2;
            Auto_QOPR_Setting = QOPR_CLOCK_X2;
            break;

        case QOPR_CLOCK_X4:
            *pClock_Rate =  CLOCK_X4;
            Auto_QOPR_Setting = QOPR_CLOCK_X4;
            break;

        case QOPR_CLOCK_X8:
            *pClock_Rate =  CLOCK_X8;
            Auto_QOPR_Setting = QOPR_CLOCK_X8;
            break;
            break;
        default:
            *pClock_Rate =  CLOCK_X1;
             Auto_QOPR_Setting = QOPR_CLOCK_X1;
        }

        QOPR_OrgValue = QOPR_OrgValue & (~QOPR_CLOCK_MASK); // clear clock bits
        QOPR_OrgValue = QOPR_OrgValue | Auto_QOPR_Setting; // Set clock bits
        // set adapter clock
        SerialWriteQOPR_Reg(Base_Address, TRUE,  QOPR_OrgValue);  
    }
    // set adapter clock
    SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_OrgValue);

    dbgprint(KERN_DEBUG"<1>SerialClkCtrlOverride:  Writing to QOPR value =  0x%04lx\n",(u_long)QOPR_OrgValue); 

    return status;
}

// SerialLockOutOverride()
//
// Check on the presences of QOR and return true if we don't get the 
// desired test pattern resuls
//
// Inputs: base address
//
// Outputs: none
//
// Returns:
//  * False if QOPR exist
//  * TRUE if jumper overridden on Qopr isn't there

bool SerialLockOutOverride(unsigned Base_Address)
{
    unsigned QOPR_OrgValue, QOPR_Value, TestOutValue;

    QOPR_OrgValue =  SerialReadQOPR_Reg( Base_Address);

    QOPR_Value = QOPR_OrgValue & QPCR_TEST_FOR1; // Clear ID0, ID1 bits
    SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_Value);


    TestOutValue = SerialReadQOPR_Reg(Base_Address);
    TestOutValue &= 0xc0;  // Mask ID0 & ID1
    if (TestOutValue != QPCR_TEST_GET1)
        return TRUE;

    QOPR_Value = QOPR_OrgValue & QPCR_TEST_FOR1; // Clear ID0, ID1 bits
    QOPR_Value = QOPR_Value | QPCR_TEST_FOR2; // set ID0, ID1 bits

    SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_Value);
    TestOutValue = SerialReadQOPR_Reg(Base_Address);

    TestOutValue &= 0xc0;    // mask off ID0 and ID1 bits

    if (TestOutValue != QPCR_TEST_GET2)
        return TRUE;

    QOPR_Value = QOPR_OrgValue & QPCR_TEST_FOR1; // Clear ID0, ID1 bits
    QOPR_Value = QOPR_Value | QPCR_TEST_FOR3; // set ID0, ID1 bits

    SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_Value);
    TestOutValue = SerialReadQOPR_Reg(Base_Address);

    TestOutValue &= 0xc0;    // mask off ID0 and ID1 bits

    if (TestOutValue != QPCR_TEST_GET3)
        return TRUE;

    QOPR_Value = QOPR_OrgValue & QPCR_TEST_FOR1; // Clear ID0, ID1 bits
    QOPR_Value = QOPR_Value | QPCR_TEST_FOR4; // set ID0, ID1 bits

    SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_Value);
    TestOutValue = SerialReadQOPR_Reg(Base_Address);

    TestOutValue &= 0xc0;    // mask off ID0 and ID1 bits

    SerialWriteQOPR_Reg(Base_Address, TRUE, QOPR_OrgValue); // Restore value


    if (TestOutValue != QPCR_TEST_GET4)
        return TRUE;

    return FALSE;
}

void exit_serial_pci(void){
    struct pci_dev_link_t *pTemp_dev_link;
    while (pPci_portlist != NULL)
    {              
        #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
        serial8250_unregister_port(pPci_portlist->line);
        #else
        unregister_serial(pPci_portlist->line);
        #endif
        
        pTemp_dev_link = pPci_portlist->next;
        kfree(pPci_portlist);
        pPci_portlist = pTemp_dev_link;
    }

    unregister_chrdev(major_number, "SerialQT_PCI");
}

module_init(init_serial_pci);
module_exit(exit_serial_pci);

----

serialqt_pci.h

/*
 * serialqt_pci.h
 *
 * Copyright (C) 2004, 2005, 2007 Tim Gobeli <tgobeli@quatech.com>
 * Copyright (C) 2012 Jonathan Woithe <jwoithe@just42.net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef __KERNEL__
#define __KERNEL__
#endif

#ifndef MODULE
#define MODULE
#endif

#ifndef EXPORT_SYMTAB
#define EXPORT_SYMTAB
#endif

#include <config/modules.h>

#include <linux/errno.h>
#include <asm/io.h>
#include <linux/pci.h>

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
#include <linux/serial_8250.h>
#else
#include <linux/serial.h>
#endif

#include <asm/uaccess.h>
#include <linux/init.h>

#define TRUE  1
#define FALSE 0
#define bool  int

#define QSC100          0x0010
#define DSC100          0x0020	
#define DSC100E         0x0181
#define DSC200          0x0030
#define DSC200E         0x01B1
#define QSC200          0x0040
#define ESC100          0x0050
#define ESC100_1        0x0060
#define QSCP100         0x0120
#define DSCP100         0x0130
#define QSCP200         0x0140
#define DSCP200         0x0150
#define QSCLP100        0x0170
#define DSCLP100        0x0180
#define SSCLP100        0x0190
#define QSCLP200        0x01A0
#define DSCLP200        0x01B0
#define SSCLP200        0x01C0
#define ESCLP100        0x01E0

#define QUATECH_VID     0x135C

#define RS232 0
#define RS422 1

#define BUFFER_LENGTH   50

typedef struct
{
    int     prodid;
    int     multi;           /* 1 = multifunction, > 1 = # ports */
    int     extended;        /* 1 = extended feature, 1 = no extended feature */
    int     type;            /* RS232 or RS422 */
    int     IO_Region;       /* I/O region of funcitonal I/O range*/ 
    bool    AMCC;
} multi_id_t;

// This is used to create a linked list of ports and to associate them with 
// a given adapter
struct pci_dev_link_t
{
    struct          pci_dev_link_t *next;
    int             prodid;
    unsigned int    ulPortStart;
    int             type;
    int             line;
    int             Port_Number;
    int             Adapter_Index;
    spinlock_t      *lock;    /* Pointer to the mutex used by serial core */
};

static multi_id_t multi_id[] =
{  
    {QSC100,    4,  1,  RS232,  1, TRUE}, 
    {DSC100,    2,  1,  RS232,  1, TRUE},
    {DSC100E,   2,  1,  RS232,  2, FALSE},
    {DSC200,    2,  1,  RS422,  1, TRUE},
    {DSC200E,    2,  1,  RS422,  2, FALSE},
    {QSC200,    4,  1,  RS422,  1, TRUE},
    {ESC100,    8,  1,  RS232,  1, TRUE},
    {ESC100_1,  8,  1,  RS232,  1, TRUE},
    {QSCP100,   4,  1,  RS232,  1, TRUE},
    {DSCP100,   2,  1,  RS232,  1, TRUE},
    {QSCP200,   4,  1,  RS422,  1, TRUE},
    {DSCP200,   2,  1,  RS422,  1, TRUE},
    {ESCLP100,  8,  1,  RS232,  0, FALSE},
    {QSCLP100,  4,  1,  RS232,  2, FALSE},
    {DSCLP100,  2,  1,  RS232,  2, FALSE},
    {SSCLP100,  1,  1,  RS232,  2, FALSE},
    {QSCLP200,  4,  1,  RS422,  2, FALSE},
    {DSCLP200,  2,  1,  RS422,  2, FALSE}, 
    {SSCLP200,  1,  1,  RS422,  2, FALSE},
};

typedef struct
{
    int     index;
    int     n_identity;           
            
} Identity_struct;

#define SERIALQT_PCI_IOC_MAGIC 'k'
#define SERIALQT_WRITE_QOPR _IOW(SERIALQT_PCI_IOC_MAGIC, 0, int)
#define SERIALQT_WRITE_QMCR _IOW(SERIALQT_PCI_IOC_MAGIC, 1, int)
#define SERIALQT_GET_NUMOF_UNITS _IOR(SERIALQT_PCI_IOC_MAGIC, 2, void *)
#define SERIALQT_GET_THIS_UNIT _IOR(SERIALQT_PCI_IOC_MAGIC, 3, void *)
#define SERIALQT_READ_QOPR _IOR(SERIALQT_PCI_IOC_MAGIC, 4, int)
#define SERIALQT_READ_QMCR _IOR(SERIALQT_PCI_IOC_MAGIC, 5, int)
#define SERIALQT_IS422_EXTENDED _IOR(SERIALQT_PCI_IOC_MAGIC, 6, int)    //returns successful if 422 extended

#define SERIALQT_IOC_MAXNR 6

// Constants to Check for presence for QOR register
#define QPCR_TEST_FOR1    0x3f  // 
#define QPCR_TEST_GET1    0x00  // (0 0 x x x x x x) in gives (0 0 x x x x x x) out
#define QPCR_TEST_FOR2    0x40  // 
#define QPCR_TEST_GET2    0x040  // (0 1 x x x x x x) in gives (0 1 x x x x x x) out
#define QPCR_TEST_FOR3    0x80  // 
#define QPCR_TEST_GET3    0x40  // (1 0 x x x x x x) in gives (0 1 x x x x x x) out
#define QPCR_TEST_FOR4    0xc0  // 
#define QPCR_TEST_GET4    0x80  // (1 1 x x x x x x) in gives (1 0 x x x x x x) out

// Quatech Options Register DWORD "QOPR" (Hardware Register)
// Lower 8 bits defined by hardware registers, upper 8 bits custom flags
#define QOPR_CLOCK_AUTO    0x0100  // (bit 8) custom flag for "Auto" data rate multiplier mode
#define QOPR_CLOCK_X1      0x0000  // (x x x x x x 0 0) force X1 clock mode   
#define QOPR_CLOCK_X2      0x0001  // (x x x x x x 0 1) force X2 clock mode
#define QOPR_CLOCK_X4      0x0002  // (x x x x x x 1 0) force X4 clock mode
#define QOPR_CLOCK_X8      0x0003  // (x x x x x x 1 1) force X8 clock mode
#define QOPR_CLOCK_MASK    0x0103  // (1)(x x x x x x 1 1) used by software to mask off bits
#define QOPR_CLOCK_RATE_MASK    0x0003  // (1)(x x x x x x 1 1) used by software to mask off bits

// Quatech Hardware Options Enable Register DWORD "HWOR" (Software Register)
// low word, low byte in HWOR defines clock multiplier options available 
#define HWOR_CLOCK_X1      0x00000001  // (x x x x x x x 1) X1 clock mode available
#define HWOR_CLOCK_X2      0x00000002  // (x x x x x x 1 x) X2 clock mode available
#define HWOR_CLOCK_X4      0x00000004  // (x x x x x 1 x x) X4 clock mode available
#define HWOR_CLOCK_X8      0x00000008  // (x x x x 1 x x x) X8 clock mode available
#define HWOR_CLOCK_AUTO    0x00000080  // (1 x x x x x x x) auto clock mode available
#define HWOR_CLOCK_CLR     0xffffff00  // (0 0 0 0 0 0 0 0) auto clock mode available
#define HWOR_CLOCK_MASK    0x000000FF  // Bit mask used to determine whether to display Advanced property page

// low word, low byte in HWOR defines clock multiplier options available 
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
    #define CLOCK_X1           1843200  // X1 clock RATE
    #define CLOCK_X2           3685400  // X2 clock RATE
    #define CLOCK_X4           7372800  // X4 clock RATE
    #define CLOCK_X8           14745600 // (X8 clock RATE
#else
    #define CLOCK_X1           115200  // X1 clock RATE
    #define CLOCK_X2           230400  // X2 clock RATE
    #define CLOCK_X4           460800  // X4 clock RATE
    #define CLOCK_X8           921600  // (X8 clock RATE
#endif

// low word, high byte in HWOR defines RS-485 transmit and receive control 
// options available
#define HWOR_DUPLEX_FULL   0x00000100  // (x x x x x x x 1) transmitters always on available
#define HWOR_DUPLEX_DTR    0x00000200  // (x x x x x x 1 x) transmitters controlled by DTR available
#define HWOR_DUPLEX_RTS    0x00000400  // (x x x x x 1 x x) transmitters controlled by RTS available
#define HWOR_DUPLEX_AUTO   0x00000800  // (x x x x 1 x x x) Auto Toggle mode available
#define HWOR_RECEIVE_NXMT  0x00008000  // (1 x x x x x x x) receivers enabled when not transmit enabled feature available
#define HWOR_XMTRVCTRL_CLR 0xfffff00ff  //(0 0 0 0 0 0 0 0) used to clear all transmit and receive control options available 

// high word, low byte in HWOR defines RS-485 signal line configuration 
// options available
#define HWOR_SIGNAL_MODEM  0x00010000  // (x x x x x x x 1) RTS to AUXOUT - CTS from AUXIN - RCLK loopback to XCLK
#define HWOR_SIGNAL_CLOCK  0x00020000  // (x x x x x x 1 x) XCLK to AUXOUT - RCLK from AUXIN - RTS loopback to CTS
#define HWOR_SIGNAL_LOOP   0x00040000  // (x x x x x 1 x x) RTS loopback to CTS - RCLK loopback to XCLK - AUXIN loopback to AUXOUT
#define HWOR_SIGNAL_CLR    0xfff0ffff  // (0 0 0 0 0 0 0 0) used to clear all transmit and receive control options available 

#define HWOR_RS485_MASK    0x000FFF00  // Bit mask used to determine whether to display RS-422/485 property page

#define HWOR_PORT_MASK    0x00100000  // Bit mask used to determine whether to Port property page
