From: Shreyas Bethur <shreyas.bethur@ni.com>
Subject: Re: [PATCH 1/1] tty: Do not set modem lines when reopening ports
Date: Wed, 5 Nov 2014 17:56:12 -0600
Message-ID: <OFCF96456C.F9F3663D-ON86257D87.008358CD-86257D87.00837D35@ni.com>
References: <OF6C85CA04.9FBB77C4-ON86257D82.007014C2-86257D82.0070E996@ni.com> <54580C09.7080901@hurleysoftware.com> <OFC3DBEDDF.98889C80-ON86257D87.006F9538-86257D87.0078F95B@ni.com> <545AB54C.1000305@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:47695 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750860AbaKEX4R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 18:56:17 -0500
In-Reply-To: <545AB54C.1000305@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org

> From: Peter Hurley <peter@hurleysoftware.com>
> To: Shreyas Bethur <shreyas.bethur@ni.com>, 
> Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, 
linux-serial@vger.kernel.org
> Date: 11/05/2014 05:40 PM
> Subject: Re: [PATCH 1/1] tty: Do not set modem lines when reopening 
ports
> 
> On 11/05/2014 05:01 PM, Shreyas Bethur wrote:
> >> From: Peter Hurley <peter@hurleysoftware.com>
> >> On 10/31/2014 04:33 PM, Shreyas Bethur wrote:
> >>> When tty port is opened, we will raise the DTR and RTS lines. But 
for
> >>> second and subsequent opens, we should not modify these lines 
because the
> >>> first session might be actively using these lines. We don't want a 
second
> >>> open to interfere with the first session.
> >>>
> >>> Signed-off-by: Shreyas Bethur <shreyas.bethur@ni.com>
> >>> ---
> >>> To give some background for this patch, we have a product that uses 
the
> >>> DTR line on the serial port for synchronization with other devices. 
While
> >>> the synchronization application is using the DTR line, if another 
process
> >>> opens the same port, then DTR line is raised, and thus interferes 
with the
> >>> synchronization application. So, if a port is open, subsequent opens
> >>> should not modify any modem lines.
> >>
> >> Would you please expand on your use-case?
> > 
> > We have many devices in a real-time test & measurement system, and the 

> > clocks on all these devices needs to be synchronized for our 
applications.
> > So we connect all the devices to a central hub via serial ports. We 
open
> > a tty session (in exclusive mode and non-admin user) and toggle the 
DTR
> > lines from all the devices, every time cycle. The hub measures the 
time
> > difference between these signals and correct the clock on the devices.
> > We also have a service that the user can use to enumerate all the 
serial
> > ports and check whether they are in use. When this service opens the 
port
> > that is used for synchronization, it gets EBUSY error, which is good; 
But
> > the tty driver raises the DTR line before returning EBUSY.
> > 
> > I would expect that if a tty session is opened in exclusive mode, any 
> > subsequent opens to not change anything on the port including DTR and 
RTS
> > lines. Please let me know if I'm missing something or if my 
understanding
> > is incorrect.
> 
> Your understanding is exactly right, and I think your application's use 
and
> expectation of TTY_EXCLUSIVE is correct as well.
> 
> But I think the appropriate fix for this is elsewhere; I need to do some
> testing but I think I can get you a test patch in the next couple of 
days.
> What kernel version are you using to test (so I can make sure the test 
patch
> applies)?
> 
> Regards,
> Peter Hurley

I'm using 3.10.31

Regards,
Shreyas Bethur
