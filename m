From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/1] tty: Do not set modem lines when reopening ports
Date: Wed, 05 Nov 2014 18:39:56 -0500
Message-ID: <545AB54C.1000305@hurleysoftware.com>
References: <OF6C85CA04.9FBB77C4-ON86257D82.007014C2-86257D82.0070E996@ni.com> <54580C09.7080901@hurleysoftware.com> <OFC3DBEDDF.98889C80-ON86257D87.006F9538-86257D87.0078F95B@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:48524 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751270AbaKEXkA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 18:40:00 -0500
In-Reply-To: <OFC3DBEDDF.98889C80-ON86257D87.006F9538-86257D87.0078F95B@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shreyas Bethur <shreyas.bethur@ni.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org

On 11/05/2014 05:01 PM, Shreyas Bethur wrote:
>> From: Peter Hurley <peter@hurleysoftware.com>
>> On 10/31/2014 04:33 PM, Shreyas Bethur wrote:
>>> When tty port is opened, we will raise the DTR and RTS lines. But for
>>> second and subsequent opens, we should not modify these lines because the
>>> first session might be actively using these lines. We don't want a second
>>> open to interfere with the first session.
>>>
>>> Signed-off-by: Shreyas Bethur <shreyas.bethur@ni.com>
>>> ---
>>> To give some background for this patch, we have a product that uses the
>>> DTR line on the serial port for synchronization with other devices. While
>>> the synchronization application is using the DTR line, if another process
>>> opens the same port, then DTR line is raised, and thus interferes with the
>>> synchronization application. So, if a port is open, subsequent opens
>>> should not modify any modem lines.
>>
>> Would you please expand on your use-case?
> 
> We have many devices in a real-time test & measurement system, and the 
> clocks on all these devices needs to be synchronized for our applications.
> So we connect all the devices to a central hub via serial ports. We open
> a tty session (in exclusive mode and non-admin user) and toggle the DTR
> lines from all the devices, every time cycle. The hub measures the time
> difference between these signals and correct the clock on the devices.
> We also have a service that the user can use to enumerate all the serial
> ports and check whether they are in use. When this service opens the port
> that is used for synchronization, it gets EBUSY error, which is good; But
> the tty driver raises the DTR line before returning EBUSY.
> 
> I would expect that if a tty session is opened in exclusive mode, any 
> subsequent opens to not change anything on the port including DTR and RTS
> lines. Please let me know if I'm missing something or if my understanding
> is incorrect.

Your understanding is exactly right, and I think your application's use and
expectation of TTY_EXCLUSIVE is correct as well.

But I think the appropriate fix for this is elsewhere; I need to do some
testing but I think I can get you a test patch in the next couple of days.
What kernel version are you using to test (so I can make sure the test patch
applies)?

Regards,
Peter Hurley
