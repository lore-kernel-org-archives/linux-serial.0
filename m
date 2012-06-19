From: Jeff Liu <jeff.liu@oracle.com>
Subject: Re: [PATCH] drivers/tty/tty_io.c: fix a potential memleak at do_tty_write()
Date: Tue, 19 Jun 2012 11:44:35 +0800
Message-ID: <4FDFF5A3.9050306@oracle.com>
References: <4FDF1DDA.3030704@oracle.com> <20120618170415.4d035911@pyramind.ukuu.org.uk> <4FDF6CCE.7090709@microgate.com>
Reply-To: jeff.liu@oracle.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31613 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab2FSDpH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 23:45:07 -0400
In-Reply-To: <4FDF6CCE.7090709@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On 06/19/2012 02:00 AM, Paul Fulghum wrote:

> On 6/18/2012 11:04 AM, Alan Cox wrote:
>> On Mon, 18 Jun 2012 20:23:54 +0800
>> Jeff Liu <jeff.liu@oracle.com> wrote:
>>
>>> Hello,
>>>
>>> Looks there is a potential memory leak at drivers/tty/tty_io.c: do_tty_write().
>>> It did allocate a buf_chunk if tty->write_cnt < chunk, however, buf_chunk was not
>>> freed after the writing is done.  Below tiny patch could fix it.
>>
>> Why should it be freed, we still have a reference to it.
> 
> Yeah, it would be messy on the next write()
> when the now freed tty->write_buf is accessed ;-)
> *boom*

Oops! I took for granted previously. Duh. :(

Sorry for the noise!

-Jeff

