From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: 8250.nr_uarts broken in 3.7
Date: Sat, 09 Mar 2013 00:14:23 +0100
Message-ID: <513A70CF.9010800@suse.cz>
References: <20130307185642.GF13719@hansolo.jdub.homelinux.org> <5138E56B.6090308@suse.cz> <20130307191005.GH13719@hansolo.jdub.homelinux.org> <20130307211426.GI13719@hansolo.jdub.homelinux.org> <20130307231242.GC4280@kroah.com> <20130308010140.GJ13719@hansolo.jdub.homelinux.org> <20130308013923.GA12474@kroah.com> <20130308212722.GL13719@hansolo.jdub.homelinux.org> <513A6A65.9050706@suse.cz> <20130308224950.GM13719@hansolo.jdub.homelinux.org> <513A6D1F.5000202@suse.cz> <513A6FD4.7000506@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33304 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab3CHXO2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Mar 2013 18:14:28 -0500
In-Reply-To: <513A6FD4.7000506@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/09/2013 12:10 AM, Jiri Slaby wrote:
> On 03/08/2013 11:58 PM, Jiri Slaby wrote:
>> On 03/08/2013 11:49 PM, Josh Boyer wrote:
>>> On Fri, Mar 08, 2013 at 11:47:01PM +0100, Jiri Slaby wrote:
>>>> Yeah, I agree this is ugly. Just re-definining MODULE_PARAM_PREFIX at
>>>> the end of the file should do the trick (followed by
>>>> "module_param(nr_uarts, uint, 0644)").
>>>
>>> For some reason, I thought I had tried that.  Maybe I didn't.  I'll look
>>> into it again.
>>
>> I see. Because we would re-define some global variables. What if we put
>> module_param into a function?
> 
> Something like this?
> #ifdef MODULE
> static void __unused splat(void) {

I meant __used. It should make no difference though.

> #       undef MODULE_PARAM_PREFIX
> #       define MODULE_PARAM_PREFIX "8250."
>         module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
>         ...
> }
> #endif
> 
> Not nice, but should work. The other way is to have those in a separate
> file linked to 8250 (to avoid re-definition errors).
> 
> thanks,
-- 
js
suse labs
