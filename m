From: Russell Coker <russell@coker.com.au>
Subject: Fwd: [max@hinterhof.net: sredird vulnerabilities]
Date: Mon, 2 Aug 2004 00:21:19 +1000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408020021.20025.russell@coker.com.au>
Reply-To: russell@coker.com.au
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.sws.net.au ([61.95.69.6]:2465 "EHLO smtp.sws.net.au")
	by vger.kernel.org with ESMTP id S265981AbUHAOV2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Aug 2004 10:21:28 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: d.sbragion@infotecna.it
Cc: kermit-support@columbia.edu, Peter Astrand <peter@cendio.se>, jaltman@columbia.edu, mario@viara.info, linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>

sercd seems to have the same issues.

----------  Forwarded Message  ----------

Subject: [max@hinterhof.net: sredird vulnerabilities]
Date: Sat, 31 Jul 2004 20:54
From: Max Vozeler <max@hinterhof.net>
To: etbe@debian.org

Hi Russell,

my mail server has problems with connections to the MX of your
coker.com.au domain (smtp.sws.net.au[61.95.69.6]), yielding 100%
packet loss, so I'm resending this to @d.o.

(Strangely the host is reachable from a different subnet. Have
you blackholed 83.137.99.0/24 or broader by any chance?)

Greets,
Max

----- Forwarded message from Max Vozeler <max@hinterhof.net> -----

From: Max Vozeler <max@hinterhof.net>
To: russell@coker.com.au
Cc: team@security.debian.org
Subject: sredird vulnerabilities
Date: Fri, 30 Jul 2004 14:52:24 +0200
User-Agent: Mutt/1.5.6+20040523i

Hi Russell,

[ CCing Security Team for vulns in the testing version ]

there are two bugs in sredird that can introduce security problems,
potentially leading to a remote root compromise. Affected in Debian is
the testing/unstable sredird 2.2.1-1.

Feel free to forward this info as you like. Unless you want me to delay
disclosure to the BTS for some reason, or the fixed package has already
entered testing by then, I'll file +security bugs in 10 days or so.

There are two bugs:

LogMsg() format string bug
--------------------------

sredird-2.2.1/sredird.c:

   458	/* Generic log function with log level control. Uses the same log
 levels 459	of the syslog(3) system call */
   460	void LogMsg(int LogLevel, const char * const Msg)
   461	  {
   462	    if (LogLevel <= MaxLogLevel)
   463	      syslog(LogLevel,Msg);
   464	  }

The log buffer in Msg is given to syslog() as format control string. This
can lead to overwriting of any memory locations in case the content of Msg
is controllable by an attacker. There is in fact one such place where the
input to LogMsg() is constructed from data as supplied by the client:

  1365	/* Handling of COM Port Control specific commands */
  1366	void HandleCPCCommand(BufferType *SockB, int PortFd, unsigned char *
 Command, size_t CSize) 1367	  {
  1368	    char LogStr[TmpStrLen];
  1369	    char SigStr[TmpStrLen];

  ..

  1376	    /* Check wich command has been requested */
  1377	    switch (Command[3])
  1378	      {
  1379	        /* Signature */
  1380	        case TNCAS_SIGNATURE:

  ..

  1391	              /* Received client signature */
  1392	              strncpy(SigStr,(char *) &Command[4],CSize - 6);
  1393	              sprintf(LogStr,"Received client signature: %s",SigStr);
  1394	              LogMsg(LOG_INFO,LogStr);

The canonical fix would be to add an explicit "%s" format string to the
syslog() call in LogMsg(). (See attached sredird-log-fmt.diff)

HandleCPCCommand() stack overflow
---------------------------------

Affected is the last chunk of code in HandleCPCCommand() shown above.
LogStr is not large enough to store the largest possible output from
sprintf(). CSize is limited to 254 by the caller, minus 6, makes a max.
SigStr length of 248 bytes. After the sprintf() with 27 or so non-format
characters, the output can grow to

  27 + 248 = 275 bytes

.. which is too much for LogStr[255], by 20 bytes or so. This may be
enough to overwrite precious stuff on the stack like saved eip depending
on stack layout.

Why not just replace it with snprintf()? This would solve this problem
for good. See attached patch sredird-hcpcc-bof.diff for example.

(There should be a LogStr[sizeof(LogStr)-1] = 0; after the snprintf in
the patch which I forgot to add)

Cheers,
Max

--
308E81E7B97963BCA0E6ED889D5BD511B7CDA2DC

--- sredird.c.orig	2004-05-01 21:45:49.000000000 +0200
+++ sredird.c	2004-05-01 21:46:05.000000000 +0200
@@ -460,7 +460,7 @@
 void LogMsg(int LogLevel, const char * const Msg)
   {
     if (LogLevel <= MaxLogLevel)
-      syslog(LogLevel,Msg);
+      syslog(LogLevel,"%s",Msg);
   }

 /* Try to lock the file given in LockFile as pid LockPid using the classical

--- sredird.c.orig	2004-05-01 22:09:28.000000000 +0200
+++ sredird.c	2004-05-01 22:10:10.000000000 +0200
@@ -1390,7 +1390,7 @@
             {
               /* Received client signature */
               strncpy(SigStr,(char *) &Command[4],CSize - 6);
-              sprintf(LogStr,"Received client signature: %s",SigStr);
+              snprintf(LogStr,sizeof(LogStr)-1,"Received client signature:
 %s",SigStr); LogMsg(LOG_INFO,LogStr);
             }
         break;




----- End forwarded message -----

--
308E81E7B97963BCA0E6ED889D5BD511B7CDA2DC

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page
