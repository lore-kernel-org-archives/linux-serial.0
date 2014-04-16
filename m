From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: How can I setup a baudrate geater then 4Mbd?
Date: Wed, 16 Apr 2014 15:59:50 +0000 (UTC)
Message-ID: <loom.20140416T175911-139@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38297 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbaDVJFG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Apr 2014 05:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WcWdS-0003wU-SN
	for linux-serial@vger.kernel.org; Tue, 22 Apr 2014 11:05:02 +0200
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2014 11:05:02 +0200
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2014 11:05:02 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I am using a following command :

BAUDRATE=3D8000000
stty -F /dev/ttyS6 ispeed $BAUDRATE ospeed $BAUDRATE -ignpar cs8 -cstop=
b =E2=80=93echo

However it does not allow me to set anything above 4Mbd or at least it =
is
not shown with a following command:

$ sudo stty -a -F /dev/ttyS6
[sudo] password for ran:
-bash: c$: command not found
speed 4000000 baud; rows 0; columns 0; line =3D 0;
ran@rg-debian-09:~/src$ [sudo] password for ran:
intr =3D <undef>; quit =3D <undef>; erase =3D <undef>; kill =3D <undef>=
; eof =3D <undef>;
-bash: [sudo]: command not found
eol =3D <undef>; eol2 =3D <undef>; swtch =3D <undef>; start =3D <undef>=
; stop =3D <undef>;
susp =3D <undef>; rprnt =3D <undef>; werase =3D <undef>; lnext =3D <und=
ef>


 As you can see a speed is a last one from a settings before. Why?

My system:

RS232 card: Jetway ADMPEOX4CA
Linux kernel :  3.2.53-rgm-rt75-nodebug #2 SMP PREEMPT RT

By

Richard


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
