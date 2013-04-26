From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 17:49:49 -0400
Message-ID: <1367012989.3971.58.camel@thor.lan>
References: <51781A19.5030707@compro.net>
	   <1366926071.3452.17.camel@thor.lan> <517A79E1.8060504@compro.net>
	   <1366983913.3452.33.camel@thor.lan> <517A8EF1.8040006@compro.net>
	  <1366994272.689.4.camel@thor.lan> <517AC4C2.3010702@compro.net>
	 <1367005866.3971.15.camel@thor.lan> <517AE2F5.4060200@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:50700 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637Ab3DZVvB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 17:51:01 -0400
In-Reply-To: <517AE2F5.4060200@compro.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: markh@compro.net
Cc: linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On Fri, 2013-04-26 at 16:26 -0400, Mark Hounschell wrote:
> On 04/26/2013 03:51 PM, Peter Hurley wrote:
> > On Fri, 2013-04-26 at 14:17 -0400, Mark Hounschell wrote:
> >> On 04/26/2013 12:37 PM, Peter Hurley wrote:
> >>> These drivers weren't really current at 3.4 though, either. I'm not sure
> >>> what else you're going to find that doesn't work.
> >>>
> >>
> >> No, I have kept them current, or I should say functional, to the best of
> >> my ability from 2.6 up to and including 3.4.x.
> >
> > By 'current', I mean 'similar in structure and functionality to in-tree
> > drivers'.
> >
> > The structure of this driver is more akin to a 2.5 driver (back when
> > there were separate serial and callout tty drivers).
> >
> >>   What I have here works
> >> with kernels up to 3.4.x. I have not tried anything between 3.4 and 3.8.
> >>    As far as building against 3.8, the only issues were the change from
> >> *termios to termios and the "structn_tty_data" no longer in an include
> >> file so not easily directly accessible.
> >
> > What is this driver accessing in N_TTY's private data?

Using the line discipline receive_buf() method directly is unsafe.

If you must, at least don't use read_cnt; use tty->receive_room. It's
not safer but at least it's accessible. [FYI - this will probably change
in the next couple of releases]

When using the tty buffer interface (!real_raw), instead of trying to
determine how much receive space is available, you need to compute how
much data is available to read and insert that with
tty_insert_flip_string_xxxx -- the tty_buffer_request_room() is
superfluous because the tty_insert_flip_string_xxxx interface already
does that for you.

Derive the equivalent tty->real_raw setting in the
driver's .set_termios() method. You can review n_tty_set_termios() to
see how to duplicate the value safely in the driver.

>          /* Decide how much data we can send into the tty layer */
>          if(dgdm_rawreadok && tty->real_raw)
>                  flip_len = MYFLIPLEN;
>          else
>                  flip_len = TTY_FLIPBUF_SIZE;
>          len = MIN(data_len, flip_len);
>          len = MIN(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
>          dxb_return_fixed_cost(dxb, channel, 1);
>          ld = tty_ldisc_ref(tty);
> .
> .
> .
> .
>                  /*
>                   * In high performance mode, we don't have to update
>                   * flag_buf or any of the counts or pointers into flip buf.
>                   */
>                  if(!dgdm_rawreadok || !tty->real_raw) {
>                          if (I_PARMRK(tty) || I_BRKINT(tty) || 
> I_INPCK(tty)) {
>                                  parity_scan(dc, myflipbuf[boardnum],
>                                          myflipflagbuf[boardnum], &len);
>                          } else {
>                                  memset(myflipflagbuf[boardnum], 
> TTY_NORMAL, len);
>                          }
>                  }
> .
> .
> .
> .
>                  /*
>                   * If we're doing raw reads, jam it right into the
>                   * line disc bypassing the flip buffers.
>                   * OPT OPP: do this only once per channel instead of
>                   * once per dxb message.
>                   */
>                  if(dgdm_rawreadok && tty->real_raw) {
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
>                          tty->ldisc->ops->receive_buf(tty, 
> myflipbuf[boardnum], NULL, len);
> #else
>                          tty->ldisc.ops->receive_buf(tty, 
> myflipbuf[boardnum], NULL, len);
> #endif
> #else
>                          tty->ldisc.receive_buf(tty, 
> myflipbuf[boardnum], NULL, len);
> #endif
>                  } else {
>                          len = tty_buffer_request_room(tty, len);
>                          tty_insert_flip_string_flags(tty, 
> myflipbuf[boardnum],
>                                  myflipflagbuf[boardnum], len);
> 
>                          /* Tell the tty layer its okay to "eat" the 
> data now */
>                          tty_flip_buffer_push(tty);
>                  }
> .
> .
> .
>          /*
>           * Just go ahead and try to read some data into the flip buffer.
>           * If there isn't any data available, dxb_rxbuf_read will return
>           * 0 back to us right away.
>           *
>           * The dgdm_rawreadok case takes advantage of carnal knowldge that
>           * the char_buf and the flag_buf are next to each other and
>           * are each of (2 * TTY_FLIPBUF_SIZE) size.
>           */
> 
>          if(dgdm_rawreadok && tty->real_raw)
>                  flip_len = MYFLIPLEN;
>          else
>                  flip_len = TTY_FLIPBUF_SIZE;
> 
>          flip_len = MIN(flip_len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
> 
>          len = dxb_rxbuf_read(brd->dxb, dc->dxbchan, 
> myflipbuf[boardnum], flip_len);
> 
> 
> etc...
> 
> Looks like for hopes of performance????
> 
> 
> 
> 
> >>> For both PCI and PCI-e, these drivers should _at a minimum_ be pci
> >>> drivers that register the tty driver at module init and register _only_
> >>> the tty devices for that particular PCI device at PCI probe time. Look
> >>> at the end of synclink_gt.c for how this is supposed to look.
> >>>
> >>
> >> I'll look at it some more but I have been there.
> >
> > Specifically, review:
> > 	struct pci_driver
> > 	device_init()
> > 	init_one()
> > 	remove_one()
> > 	sglt_init()
> > 	sglt_exit()
> >
> 
> Ok, I'll will look more closely at these to try to understand what 
> should be done.

Don't bother; I looked over the code that's still downloadable from
digi.com (which seems to be your baseline) and for your needs, this
change would be pointless.

Regards,
Peter Hurley


