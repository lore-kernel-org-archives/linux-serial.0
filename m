From: Stas Sergeev <stsp-cmBhpYW9OiY@public.gmane.org>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Sat, 04 May 2013 13:37:03 +0400
Message-ID: <5184D6BF.5040701@list.ru>
References: <5183D196.2080305@list.ru> <20130503163008.GA30699@kroah.com> <5183F62A.1020801@list.ru> <20130503165231.GA1966@kroah.com> <5183FC83.8090602@list.ru> <20130503171618.GA16686@kroah.com> <51840186.7000608@list.ru> <20130503203419.GA25932@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130503203419.GA25932-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jarkko Huijts <jarkko.huijts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

04.05.2013 00:34, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Don't call select for every character :)
OK, let me draw an approximate workflow of the
setup in question.
Lets say we have 3 tty devices, A, B and C.
A and B are blazingly fast, while C is a casual usb-serial
chip.
The app must establish a bidirectional relay between
A and C, making sure that the output queue on C never
exceeds some margin M. B is used for acknowledges: the
next char from A will arrive only after an acknowledge is
sent via B.

Here's what the app approximately does:
1. select() on A and C for _input only_.
2. relay the char
3. if the char was from A, send ack to B and increment
an ack counter (call that counter Q).
4. If Q>N (N is a threshold value that should be below M,
currently 14), do TIOCOUTQ ioctl to make sure C is not
overflowing, set Q to the value returned by TIOCOUTQ. If
Q still above N, stop sending acks to B and do TIOCOUTQ
periodically, until Q is below N, then resume the normal
operations.
5. goto 1

So that's the workflow, and it used to work perfectly in the
past. Now even on step 1, when select returns, there is
already a big delay. Not to speak about TIOCOUTQ, a very
funny way to query the buffer: the buffer is now entirely
flushed while we query it.
What exactly is so horrible here that it was deserved to break?
How to improve the algo? And no, we can't improve the protocol.
=46or instance, we can't send multiple acks and hope that multiple
chars will be received from A - the protocol cannot be changed.
Any suggestions?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
