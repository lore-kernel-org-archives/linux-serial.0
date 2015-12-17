From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH] use callbacks to access UART_DLL/UART_DLM
Date: Thu, 17 Dec 2015 20:14:13 +0100
Message-ID: <56730985.1080609@free.fr>
References: <5672D89A.4090307@laposte.net>
 <yw1xoadpcbbn.fsf@unicorn.mansr.com> <5672F9C9.1010601@laposte.net>
 <yw1xbn9pc5h8.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1xbn9pc5h8.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Sebastian Frias <sf84@laposte.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm@opensource.se>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 17/12/2015 19:09, M=E5ns Rullg=E5rd wrote:

> It could well be that your patch results in a clearer final version, =
but
> the diff is harder to parse when unchanged lines have moved around.

When all other things are equal, is the priority

1) making the patch as clear as possible?
2) making the resulting code as clear as possible?

On a related note, I remember spotting a problem in a phy driver
commit, and was told (by you) that I should split my fix in 3 (!!)
patches. I'm sorry, but that's a double standard, why would the
initial committer be given the leeway to post a single patch,
but someone willing to clean up his mess should work harder?

End result: I left the bug in there.

Regards.
