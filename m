From: Dominique Larchey <larchey@loria.fr>
Subject: Re: New IOCTL for Modem Control Lines monitoring
Date: Thu, 25 Jan 2007 20:00:11 +0100
Message-ID: <45B8FE3B.3030705@loria.fr>
References: <000701c740af$852c83d0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from postfix1-g20.free.fr ([212.27.60.42]:38809 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965582AbXAYTBO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Jan 2007 14:01:14 -0500
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by postfix1-g20.free.fr (Postfix) with ESMTP id ED2A986BB9E
	for <linux-serial@vger.kernel.org>; Thu, 25 Jan 2007 20:01:12 +0100 (CET)
In-Reply-To: <000701c740af$852c83d0$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

Tosoni a =E9crit :
> Sounds like an equivalent to WaitCommEvent in Windows NT.
>=20
> But there is a problem in Linux, which does not exist in Windows wher=
e the
> serial port is locked by the requesting process: in Linux you would h=
ave to
> associate your "recorded state" with the requesting process, because =
several
> processes may use your new ioctl at the same time.

Yes the recorded state COULD BE recorded by the same process that makes
the call. This process can get the status by reading the OUTPUT
icount.reserved[0] field each time the ioctl(uart_wait_new_status)
returns. Several processes can wait for a change each wrt to its own
"recorded state".

> Or, you can say that it's a feature of your ioctl to handle only one =
process
> :-)

This restriction is not necessary I think.

> Also, in Windows there is an extra feature, you can set a mask of whi=
ch
> signal changes you want to monitor, you might want this feature as we=
ll

It exists in the code. Indeed, the INPUT field icount.reserved[0]
contains the corresponding mask. If this mask is 0, then the behavior
is not to wait forever but to return immediately, given back the
current modem status in the OUTPUT icount.reserved[0] field.

Regards,

Dominique LW
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
