From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 12/20] n_tty: Factor standard per-char i/o into separate
 fn
Date: Tue, 23 Jul 2013 20:49:08 -0400
Message-ID: <51EF2484.70102@hurleysoftware.com>
References: <1371305069-5366-1-git-send-email-peter@hurleysoftware.com> <1371306096-5571-1-git-send-email-peter@hurleysoftware.com> <1371306096-5571-13-git-send-email-peter@hurleysoftware.com> <20130724001259.GA9239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:36553 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758194Ab3GXAtM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Jul 2013 20:49:12 -0400
In-Reply-To: <20130724001259.GA9239@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On 07/23/2013 08:12 PM, Greg Kroah-Hartman wrote:
> On Sat, Jun 15, 2013 at 10:21:28AM -0400, Peter Hurley wrote:
>> Simplify __receive_buf() into a dispatch function; perform per-char
>> processing for all other modes not already handled.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>   drivers/tty/n_tty.c | 28 ++++++++++++++++++----------
>>   1 file changed, 18 insertions(+), 10 deletions(-)
>
> This patch causes the warning:
> 	drivers/tty/n_tty.c: In function =E2=80=98n_tty_receive_buf_standard=
=E2=80=99:
> 	drivers/tty/n_tty.c:1575:21: warning: unused variable =E2=80=98ldata=
=E2=80=99 [-Wunused-variable]
> to happen.
>
> Care to fix it up, and refresh the rest of the series (something fail=
s
> later on), and resend these so that I can apply them?

Sorry about that. Working on it right now.

I think these errors came out of a reordering rebase I did by hand
a while back. Obviously I need to add per-patch build testing to my
workflow. Time to get an SSD :)

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
