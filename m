From: Mark Hounschell <markh@compro.net>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 16:26:29 -0400
Message-ID: <517AE2F5.4060200@compro.net>
References: <51781A19.5030707@compro.net>   <1366926071.3452.17.camel@thor.lan> <517A79E1.8060504@compro.net>   <1366983913.3452.33.camel@thor.lan> <517A8EF1.8040006@compro.net>  <1366994272.689.4.camel@thor.lan> <517AC4C2.3010702@compro.net> <1367005866.3971.15.camel@thor.lan>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:44934 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354Ab3DZU0b (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 16:26:31 -0400
In-Reply-To: <1367005866.3971.15.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On 04/26/2013 03:51 PM, Peter Hurley wrote:
> On Fri, 2013-04-26 at 14:17 -0400, Mark Hounschell wrote:
>> On 04/26/2013 12:37 PM, Peter Hurley wrote:
>>> These drivers weren't really current at 3.4 though, either. I'm not sure
>>> what else you're going to find that doesn't work.
>>>
>>
>> No, I have kept them current, or I should say functional, to the best of
>> my ability from 2.6 up to and including 3.4.x.
>
> By 'current', I mean 'similar in structure and functionality to in-tree
> drivers'.
>
> The structure of this driver is more akin to a 2.5 driver (back when
> there were separate serial and callout tty drivers).
>
>>   What I have here works
>> with kernels up to 3.4.x. I have not tried anything between 3.4 and 3.8.
>>    As far as building against 3.8, the only issues were the change from
>> *termios to termios and the "structn_tty_data" no longer in an include
>> file so not easily directly accessible.
>
> What is this driver accessing in N_TTY's private data?
>
         /* Decide how much data we can send into the tty layer */
         if(dgdm_rawreadok && tty->real_raw)
                 flip_len = MYFLIPLEN;
         else
                 flip_len = TTY_FLIPBUF_SIZE;
         len = MIN(data_len, flip_len);
         len = MIN(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
         dxb_return_fixed_cost(dxb, channel, 1);
         ld = tty_ldisc_ref(tty);
.
.
.
.
                 /*
                  * In high performance mode, we don't have to update
                  * flag_buf or any of the counts or pointers into flip buf.
                  */
                 if(!dgdm_rawreadok || !tty->real_raw) {
                         if (I_PARMRK(tty) || I_BRKINT(tty) || 
I_INPCK(tty)) {
                                 parity_scan(dc, myflipbuf[boardnum],
                                         myflipflagbuf[boardnum], &len);
                         } else {
                                 memset(myflipflagbuf[boardnum], 
TTY_NORMAL, len);
                         }
                 }
.
.
.
.
                 /*
                  * If we're doing raw reads, jam it right into the
                  * line disc bypassing the flip buffers.
                  * OPT OPP: do this only once per channel instead of
                  * once per dxb message.
                  */
                 if(dgdm_rawreadok && tty->real_raw) {
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
                         tty->ldisc->ops->receive_buf(tty, 
myflipbuf[boardnum], NULL, len);
#else
                         tty->ldisc.ops->receive_buf(tty, 
myflipbuf[boardnum], NULL, len);
#endif
#else
                         tty->ldisc.receive_buf(tty, 
myflipbuf[boardnum], NULL, len);
#endif
                 } else {
                         len = tty_buffer_request_room(tty, len);
                         tty_insert_flip_string_flags(tty, 
myflipbuf[boardnum],
                                 myflipflagbuf[boardnum], len);

                         /* Tell the tty layer its okay to "eat" the 
data now */
                         tty_flip_buffer_push(tty);
                 }
.
.
.
         /*
          * Just go ahead and try to read some data into the flip buffer.
          * If there isn't any data available, dxb_rxbuf_read will return
          * 0 back to us right away.
          *
          * The dgdm_rawreadok case takes advantage of carnal knowldge that
          * the char_buf and the flag_buf are next to each other and
          * are each of (2 * TTY_FLIPBUF_SIZE) size.
          */

         if(dgdm_rawreadok && tty->real_raw)
                 flip_len = MYFLIPLEN;
         else
                 flip_len = TTY_FLIPBUF_SIZE;

         flip_len = MIN(flip_len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);

         len = dxb_rxbuf_read(brd->dxb, dc->dxbchan, 
myflipbuf[boardnum], flip_len);


etc...

Looks like for hopes of performance????




>>> For both PCI and PCI-e, these drivers should _at a minimum_ be pci
>>> drivers that register the tty driver at module init and register _only_
>>> the tty devices for that particular PCI device at PCI probe time. Look
>>> at the end of synclink_gt.c for how this is supposed to look.
>>>
>>
>> I'll look at it some more but I have been there.
>
> Specifically, review:
> 	struct pci_driver
> 	device_init()
> 	init_one()
> 	remove_one()
> 	sglt_init()
> 	sglt_exit()
>

Ok, I'll will look more closely at these to try to understand what 
should be done.


Here is the init_module funtion FYI.

GLOBAL int init_module(void)
{
     int rc;

         /* make sure that the globals are init'd before we do anything 
else */
         dgdm_init_globals();

         dgdm_NumBoards = 0;
         dgdm_Major_Serial_Registered = FALSE;
         dgdm_Major_Callout_Registered = FALSE;
         dgdm_Major_TransparentPrint_Registered = FALSE;
         dgdm_Major_Control_Registered = FALSE;
         dgdm_Major_ISDN_Registered = FALSE;

         APR(("%s, Digi International Part Number %s\n", DG_NAME, DG_PART));

         /*
          * Find and configure all the cards
          */

         rc = dgdm_init_pci();

         if (!rc) {
                 /*
                  * At least one card was found, register the devices
                  * with the kernel.
                  */
                 dgdm_proc_register_basic();

                 if (dgdm_tty) {
                         rc = dgdm_tty_init();  // This is the function 
that creates all the device entries
                         if (rc < 0) {
                                 dgdm_tty_uninit();
                                 APR(("Can't init tty devices (%d)\n", rc));
                                 return (rc);
                         }
                         /*
                          * Register FEP related /proc files
                          */
                         dgdm_proc_register_fep();
                 }
                 if (!dgdm_Major_Control_Registered) {
                         /*
                          * Register memory/control/debug/mangement devices
                          */
                         rc = register_chrdev(major + DGDM_CONTROL_MAJOR,
                                              "dxb", &BoardFops);
                         if (rc < 0) {
                                 APR(("Can't register ram device 
(%d)\n", rc));
                                 return (rc);
                         }
                         dgdm_Major_Control_Registered = TRUE;
                 }
                 if (dgdm_isdn && !dgdm_Major_ISDN_Registered) {
                         /*
                          * Register ISDN testing device
                          */
                         rc = register_chrdev(major + DGDM_ISDN_MAJOR,
                                              "dxbisdn", 
&dgdm_BoardIsdnFops);
                         if (rc < 0) {
                                 APR(("Can't register ISDN device 
(%d)\n", rc));
                                 return (rc);
                         }
                         dgdm_Major_ISDN_Registered = TRUE;
                 }
                 if(dgdm_NumBoards > 4) {
                         if (!dgdm_Major_Control2_Registered) {
                                 rc = 
register_chrdev(major+DGDM_CONTROL2_MAJOR,
                                                      "dxb2", &BoardFops);
                                 if (rc < 0) {
                                         APR(("Can't register high ram "
                                              "device (%d)\n", rc));
                                         return (rc);
                                 }
                                 dgdm_Major_Control2_Registered = TRUE;
                         }
                         if (dgdm_isdn && !dgdm_Major_ISDN2_Registered) {
                                 rc = register_chrdev(major + 
DGDM_ISDN2_MAJOR,
                                                      "dxbisdn2", 
&dgdm_BoardIsdnFops);
                                 if (rc < 0) {
                                         APR(("Can't register high ISDN "
                                              "devices (%d)\n", rc));
                                         return (rc);
                                 }
                                 dgdm_Major_ISDN2_Registered = TRUE;
                         }
                 }

                 //       Compro Computer Svcs udev support
                 // Need udev notification of the dgdm_mgmt device creation
                 //
                 // See config/99-dgdm.rules 
"/etc/udev/rules.d/99-dgdm.rules"
                 // and /usr/local/sbin/dgdm
                 //
                 if (alloc_chrdev_region(&dgdm_mgmt_major, 0, 1, 
"dgdm_mgmt") != 0) {
                         printk("DGDM: Unable to get MAJOR/MINOR device 
numbers\n");
                         return -ENODEV;
                 }

                 dgdm_mgmt_device = cdev_alloc();
                 if (dgdm_mgmt_device <= 0) {
                         printk("DGDM: Unable to alloc cdev struct\n");
                         return -ENODEV;
                 }

                 cdev_init(dgdm_mgmt_device, &dgdm_BoardIsdnFops);
                 dgdm_mgmt_device->owner = THIS_MODULE;

                 if (cdev_add(dgdm_mgmt_device, dgdm_mgmt_major, 1) < 0) {
                         printk("DGDM: Error Registering chrdev device\n");
                         return -ENODEV;
                 }

                 dgdm_mgmt_class = class_create(THIS_MODULE, "dgdm_mgmt");
                 if (IS_ERR(dgdm_mgmt_class)) {
                         printk("DGDM: Error creating class\n");
                         return -ENODEV;
                 }

                 device_dgdm_mgmt = device_create(dgdm_mgmt_class, NULL, 
dgdm_mgmt_major, NULL, "dgdm_mgmt");
                 if (IS_ERR(device_dgdm_mgmt)) {
                         printk("DGDM: Error creating device entry\n");
                         return -ENODEV;
                 }
         } else {
                 cleanup_module();
         }

         return (rc);
}


Mark
