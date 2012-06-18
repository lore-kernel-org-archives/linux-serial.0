From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: [PATCH] drivers/tty/tty_io.c: fix a potential memleak at do_tty_write()
Date: Mon, 18 Jun 2012 13:00:46 -0500
Message-ID: <4FDF6CCE.7090709@microgate.com>
References: <4FDF1DDA.3030704@oracle.com> <20120618170415.4d035911@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from omr2pod1.networksolutionsemail.com ([206.188.198.67]:55194 "EHLO
	omr2pod1.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751951Ab2FRSKB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 14:10:01 -0400
Received: from mail.networksolutionsemail.com (mailpod1.networksolutionsemail.com [206.188.198.65])
	by omr2pod1.networksolutionsemail.com (8.13.8/8.13.8) with ESMTP id q5II0lx5015736
	for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 14:00:47 -0400
In-Reply-To: <20120618170415.4d035911@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff.liu@oracle.com, linux-serial@vger.kernel.org

On 6/18/2012 11:04 AM, Alan Cox wrote:
> On Mon, 18 Jun 2012 20:23:54 +0800
> Jeff Liu <jeff.liu@oracle.com> wrote:
> 
>> Hello,
>>
>> Looks there is a potential memory leak at drivers/tty/tty_io.c: do_tty_write().
>> It did allocate a buf_chunk if tty->write_cnt < chunk, however, buf_chunk was not
>> freed after the writing is done.  Below tiny patch could fix it.
> 
> Why should it be freed, we still have a reference to it.

Yeah, it would be messy on the next write()
when the now freed tty->write_buf is accessed ;-)
*boom*

-- 
Paul Fulghum
MicroGate Systems, Ltd.
