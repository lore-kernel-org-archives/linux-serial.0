From: Peter Astrand <peter@cendio.se>
Subject: Re: Fwd: [max@hinterhof.net: sredird vulnerabilities]
Date: Sun, 1 Aug 2004 17:47:37 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0408011739070.12619-100000@maggie.lkpg.cendio.se>
References: <200408020021.20025.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cheddar.cendio.se ([193.12.253.77]:10736 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S265663AbUHAPrk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Aug 2004 11:47:40 -0400
In-Reply-To: <200408020021.20025.russell@coker.com.au>
List-Id: linux-serial@vger.kernel.org
To: Max Vozeler <max@hinterhof.net>
Cc: d.sbragion@infotecna.it, kermit-support@columbia.edu, jaltman@columbia.edu, mario@viara.info, linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>, Russell Coker <russell@coker.com.au>


> LogMsg() format string bug
> --------------------------
=2E..
> The canonical fix would be to add an explicit "%s" format string to t=
he
> syslog() call in LogMsg(). (See attached sredird-log-fmt.diff)

Thanks for pointing this out.=20


> HandleCPCCommand() stack overflow
> ---------------------------------
>=20
> Affected is the last chunk of code in HandleCPCCommand() shown above.
> LogStr is not large enough to store the largest possible output from
> sprintf(). CSize is limited to 254 by the caller, minus 6, makes a ma=
x.
> SigStr length of 248 bytes.=20

Since CSize is a size_t, it can be larger than 254. I'd rather not depe=
nd=20
on the caller calling with max 254. Therefore, I've added an explicit=20
check to make sure we are not copying more than SigStr can hold:

strncpy(SigStr, (char *) &Command[4],
        MAX(CSize - 6, sizeof(SigStr) - 1));

>After the sprintf() with 27 or so non-format
> characters, the output can grow to
>=20
>   27 + 248 =3D 275 bytes
>=20
> .. which is too much for LogStr[255], by 20 bytes or so. This may be
> enough to overwrite precious stuff on the stack like saved eip depend=
ing
> on stack layout.
>=20
> Why not just replace it with snprintf()? This would solve this proble=
m
> for good.=20

Good idea. This is the patch I've committed to the sercd CVS:

diff -u -r1.8 sercd.c
--- sercd.c     1 Aug 2004 15:03:17 -0000       1.8
+++ sercd.c     1 Aug 2004 15:36:04 -0000
@@ -144,6 +144,11 @@
 /* Default modem state polling in milliseconds (100 msec should be=20
enough) */
 #define ModemStatePolling 100
=20
+/* macros */
+#ifndef MAX
+#define MAX(x,y)                (((x) > (y)) ? (x) : (y))
+#endif
+
 /* Standard boolean definition */
 typedef enum
 { False, True } Boolean;
@@ -420,7 +425,7 @@
 LogMsg(int LogLevel, const char *const Msg)
 {
     if (LogLevel <=3D MaxLogLevel)
-       syslog(LogLevel, Msg);
+       syslog(LogLevel, "%s", Msg);
 }
=20
 /* Try to lock the file given in LockFile as pid LockPid using the=20
classical
@@ -1339,8 +1344,11 @@
        }
        else {
            /* Received client signature */
-           strncpy(SigStr, (char *) &Command[4], CSize - 6);
-           sprintf(LogStr, "Received client signature: %s", SigStr);
+           strncpy(SigStr, (char *) &Command[4],
+                   MAX(CSize - 6, sizeof(SigStr) - 1));
+           snprintf(LogStr, sizeof(LogStr) - 1,
+                    "Received client signature: %s", SigStr);
+           LogStr[sizeof(LogStr) - 1] =3D '\0';
            LogMsg(LOG_INFO, LogStr);
        }
        break;

As soon as I've been able to test-run the latest CVS, I'll make a new=20
release. This should happen later today or tomorrow.=20

--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
