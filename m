From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: PROBLEM: BUG: scheduling while atomic in the 8250 serial driver
Date: Sat, 1 Feb 2014 16:04:36 +0100
Message-ID: <20140201150436.GA8992@kroah.com>
References: <52ECED0D.4090202@ewanet.ch>
 <52ED07F1.60304@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59155 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaBAPDO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Feb 2014 10:03:14 -0500
Content-Disposition: inline
In-Reply-To: <52ED07F1.60304@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Beat Bolli <bbolli@ewanet.ch>, linux-serial@vger.kernel.org

On Sat, Feb 01, 2014 at 09:42:57AM -0500, Peter Hurley wrote:
> On 02/01/2014 07:48 AM, Beat Bolli wrote:
> > Hi
> 
> Hi Beat,
> 
> > Firstly, I hope that my analysis of the stack trace is correct and this
> > is really a serial driver problem. Anyway, here goes:
> >
> > I have a serial GPS with PPS on the RTS pin attached to my Atom N270
> > motherboard, using it, besides being my home server and Internet
> > gateway, as a Stratum 0 NTP server. Recently[1], the kernel started
> > producing BUGs as follows:
> >
> > [10671.576706] BUG: scheduling while atomic: blosxom.cgi/8118/0x10010000
> 
> <snip>
> 
> > [10671.578517] Call Trace:
> > [10671.578538]  [<c13fe5a9>] ? dump_stack+0x3e/0x4e
> > [10671.578549]  [<c13fc1c8>] ? __schedule_bug+0x4d/0x5e
> > [10671.578561]  [<c140113c>] ? __schedule+0x6fc/0x710
> > [10671.578573]  [<c1076170>] ? wake_up_state+0x10/0x10
> > [10671.578584]  [<c114fba0>] ? poll_select_copy_remaining+0x110/0x110
> > [10671.578595]  [<c1070676>] ? __wake_up_common+0x46/0x70
> > [10671.578606]  [<c1074593>] ? __cond_resched+0x13/0x30
> > [10671.578615]  [<c140145d>] ? _cond_resched+0x1d/0x30
> > [10671.578624]  [<c1400758>] ? down_read+0x8/0x20
> > [10671.578636]  [<c12b59dc>] ? n_tty_receive_buf2+0x2c/0xb0
> > [10671.578656]  [<c12b59b0>] ? __receive_buf+0x7b0/0x7b0
> > [10671.578666]  [<c12b89ba>] ? flush_to_ldisc+0xba/0x110
> 
> You can't use low_latency; only devices that receive data in
> non-interrupt contexts (such as USB serial devices) can.

USB serial devices get their data in interrupt context, until we fix USB
callbacks to be threaded, which might happen one day...

greg k-h
