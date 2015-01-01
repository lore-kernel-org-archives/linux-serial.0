From: Christian Riesch <christian.riesch@omicron.at>
Subject: Re: [PATCH] n_tty: Fix unordered accesses to lockless read buffer
Date: Thu, 1 Jan 2015 14:55:50 +0100
Message-ID: <CABkLObp9jt6y94Ss6H=F2UGm4n1kv9jJU2tJfdg+EUO=e=BVNw@mail.gmail.com>
References: <1419941156-5303-1-git-send-email-peter@hurleysoftware.com>
	<CABkLObqhqE7Y3eD2gUxmqb0etfvYcDYRnE=-i=-4j=4Ea6=F-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CABkLObqhqE7Y3eD2gUxmqb0etfvYcDYRnE=-i=-4j=4Ea6=F-w@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 1, 2015 at 12:00 PM, Christian Riesch >> @@ -164,15
+160,17 @@ static inline int tty_put_user(struct tty_struct *tty,
unsigned char x,
>>  static int receive_room(struct tty_struct *tty)
>>  {
>>         struct n_tty_data *ldata = tty->disc_data;
>> +       size_t head = ACCESS_ONCE(ldata->commit_head);
>> +       size_t tail = ACCESS_ONCE(ldata->read_tail);
>>         int left;
>>
>>         if (I_PARMRK(tty)) {
>> -               /* Multiply read_cnt by 3, since each byte might take up to
>> +               /* Multiply count by 3, since each byte might take up to
>>                  * three times as many spaces when PARMRK is set (depending on
>>                  * its flags, e.g. parity error). */
>> -               left = N_TTY_BUF_SIZE - read_cnt(ldata) * 3 - 1;
>> +               left = N_TTY_BUF_SIZE - (head - tail) * 3 - 1;
>>         } else
>> -               left = N_TTY_BUF_SIZE - read_cnt(ldata) - 1;
>> +               left = N_TTY_BUF_SIZE - (head - tail) - 1;
>
> Actually, less room may be available, if read_head != commit_head.
> Could this cause problems? I guess yes, at least in
> n_tty_receive_buf_common, where this could lead to a buffer overflow,
> right?

Sorry, should not be a problem, at least not for
n_tty_receive_buf_common, since this is producer path, right? But how
about the other calls of receive_room()?

Christian
