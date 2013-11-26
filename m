From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 7/7] n_tty: trace input/read flow control
Date: Tue, 26 Nov 2013 08:00:35 -0500
Message-ID: <52949B73.3000206@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>	<1385135965-4235-8-git-send-email-peter@hurleysoftware.com> <20131124002513.0a806665@alan.etchedpixels.co.uk> <529166C0.8040001@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:57742 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083Ab3KZNAk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Nov 2013 08:00:40 -0500
In-Reply-To: <529166C0.8040001@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 11/23/2013 09:38 PM, Peter Hurley wrote:
> On 11/23/2013 07:25 PM, One Thousand Gnomes wrote:
>> On Fri, 22 Nov 2013 10:59:25 -0500
>> Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>>> Instrument .receive_buf() and read() paths with trace_printk's
>>> to aid in debugging flow control changes.
>>
>> tty devices have a device, we have a dev_dbg() layer. The old tty trace
>> predates this but there isn't really any excuse for not using it now that
>> I can see ?
>
> I was using the ftrace facility because it has significantly less performance
> impact than printk (which was an important factor while debugging flow control
> problems).
>
> That said, I could further macro-ize n_tty_trace() with selectable facility
> (which would be useful when debugging problems that end in cpu death).

Greg,

I don't really mind if you don't want to take this patch; it is useful but
it does clutter up the code.

Regards,
Peter Hurley
