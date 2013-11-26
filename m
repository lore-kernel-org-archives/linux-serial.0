From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 1/5] tty: Always handle NULL flag ptr
Date: Mon, 25 Nov 2013 21:00:19 -0500
Message-ID: <529400B3.4070003@hurleysoftware.com>
References: <1385140198-5822-1-git-send-email-peter@hurleysoftware.com> <1385140198-5822-2-git-send-email-peter@hurleysoftware.com> <20131122222040.GA12800@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:52202 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751897Ab3KZCAW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Nov 2013 21:00:22 -0500
In-Reply-To: <20131122222040.GA12800@core.coreip.homeip.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 11/22/2013 05:20 PM, Dmitry Torokhov wrote:
> Hi Peter,
>
> On Fri, Nov 22, 2013 at 12:09:54PM -0500, Peter Hurley wrote:
>> Most line disciplines already handle the undocumented NULL flag
>> ptr in their .receive_buf method; however, several don't.
>>
>> Document the NULL flag ptr, and correct handling in the
>> N_MOUSE, N_GSM0710 and N_R394 line disciplines.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>   drivers/input/serio/serport.c | 28 +++++++++++++++-------------
>>   drivers/tty/n_gsm.c           |  5 +++--
>>   drivers/tty/n_r3964.c         |  2 +-
>>   include/linux/tty_ldisc.h     |  6 ++++--
>>   4 files changed, 23 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
>> index 8755f5f..72b4633 100644
>> --- a/drivers/input/serio/serport.c
>> +++ b/drivers/input/serio/serport.c
>> @@ -124,7 +124,7 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
>>   {
>>   	struct serport *serport = (struct serport*) tty->disc_data;
>>   	unsigned long flags;
>> -	unsigned int ch_flags;
>> +	unsigned int ch_flags = TTY_NORMAL;
>
> We should not be passing tty constants into serio layer as they are
> different subsystems (even though TTY_NORMAL happens to be encoded as 0
> and thus happens to work). Please use 0 for 'no flags' as the original
> code did.

Ah, I see your point. I'll respin this for your ack.

Regards,
Peter Hurley

