From: =?ISO-8859-1?Q?St=E9phane_Marchesin?= <marcheu@chromium.org>
Subject: Re: [PATCH] drivers/tty: Don't hangup shared ttys
Date: Tue, 11 Jun 2013 16:19:47 -0700
Message-ID: <CADMs+9ZWnz4zFqa69QoHfbOLc7Yxn2Cvo-NTNdAhw8-uPm9M6A@mail.gmail.com>
References: <1370991787-24141-1-git-send-email-marcheu@chromium.org> <20130611231518.GA28106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:58848 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3FKXUH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jun 2013 19:20:07 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so18938936iec.35
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2013 16:20:07 -0700 (PDT)
In-Reply-To: <20130611231518.GA28106@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, jslaby@suse.cz, olof@lixom.net, linux-serial@vger.kernel.org

On Tue, Jun 11, 2013 at 4:15 PM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Tue, Jun 11, 2013 at 04:03:07PM -0700, St=E9phane Marchesin wrote:
>> When quickly restarting X servers, we can run into a situation where
>> one X server quits while another one starts on the same tty. For a
>> while, two X servers share the tty, and when the old X server
>> eventually quits, the tty layer hangs up the tty, which among other
>> things stubs out the tty's ioctl functions. Later on, the new X
>> server (which shares the tty functions) tries to call some ioctls
>> on the tty and fails because they have been replaced with the hungup
>> versions. This in turn causes the new X server to abort.
>>
>> This patch checks the tty->count to make sure we're the last
>> consumer before hanging up a tty.
>>
>> Signed-off-by: St=E9phane Marchesin <marcheu@chromium.org>
>> ---
>>  drivers/tty/tty_io.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>> index 6464029..62a0f02 100644
>> --- a/drivers/tty/tty_io.c
>> +++ b/drivers/tty/tty_io.c
>> @@ -619,6 +619,9 @@ static void __tty_hangup(struct tty_struct *tty,=
 int exit_session)
>>       if (!tty)
>>               return;
>>
>> +     /* Don't hangup if there are other users */
>> +     if (tty->count > 1)
>> +             return;
>
> What happens when you have a "real" tty that was hungup because it wa=
s
> disconnected physically from the system yet userspace had a tty open?
> You want those ttys to be hungup properly, right?  Doesn't this chang=
e
> break that?

My understanding was that they'd have a different tty_struct. Is that
not the case? If so how would you recommend fixing the problem I
described?

St=E9phane
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
