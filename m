From: Corey Minyard <minyard@acm.org>
Subject: Re: Serial port redirection
Date: Fri, 05 Dec 2003 15:10:35 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FD0F44B.8080906@acm.org>
References: <Pine.LNX.4.44.0312051007200.11858-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070106000202060107040905"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63419 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264326AbTLEVKi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Dec 2003 16:10:38 -0500
In-Reply-To: <Pine.LNX.4.44.0312051007200.11858-100000@maggie.lkpg.cendio.se>
List-Id: linux-serial@vger.kernel.org
To: Peter Astrand <peter@cendio.se>
Cc: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106000202060107040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My mailer screwed up, so this might be a dup.

Here's another patch, relative to 2.0 of ser2net.  Hopefully it fixes 
this problem.

-Corey

Peter Astrand wrote:

>
>> I've attached a ser2net patch for this.  Could you try it out?
>
>
> It's a good start, but it's not enough. cyclades-ser-cli doesn't 
> finished the initialization; it seems to be waiting for ACKs for the 
> SET-MODEMSTATE-MASK op.
>
>> >* ser2net is totally incompatible with cyclades-serial-client. This is
>> >because ser2net interprets RFC2217 a bit differently. sredird sends
>> >command "101" as ack for command "1", while ser2net sends "1". 
>> RFC2217 is
>> >not very explicit about which way is most correct. The ser2net approach
>> >looks better to me, but the sredird one is probably more widely used
>> >(since Cyclades terminal server uses it, for example.) Probably, 
>> RFC2217
>> >software needs to handle both cases.
>
>
>


--------------070106000202060107040905
Content-Type: text/plain;
 name="ser2net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ser2net.diff"

? .libs
? Makefile
? Makefile.in
? aclocal.m4
? config.cache
? config.log
? config.status
? configure
? libtool
? ser2net
? ser2net-2.0.tar.gz
? ser2net-2.1.tar.gz
? .deps/controller.P
? .deps/dataxfer.P
? .deps/devcfg.P
? .deps/readconfig.P
? .deps/selector.P
? .deps/ser2net.P
? .deps/telnet.P
? .deps/utils.P
Index: ChangeLog
===================================================================
RCS file: /cvsroot/ser2net/ser2net/ChangeLog,v
retrieving revision 1.36
diff -u -r1.36 ChangeLog
--- ChangeLog	14 Oct 2003 20:52:13 -0000	1.36
+++ ChangeLog	5 Dec 2003 20:58:02 -0000
@@ -1,4 +1,27 @@
 
+2003-12-04  Corey Minyard <minyard@acm.org>
+
+	* dataxfer.c: Add responses for all the telnet com port
+	control commands that we handle.
+
+	* telnet.c: Fixed IAC processing in suboption to be able
+	to handle a stream of IACs properly.
+
+2003-12-04  Corey Minyard <minyard@acm.org>
+
+	* configure.in: Moved to version 2.1.
+
+	* dataxfer.c: Have the telnet option responses use the 1xx
+	responses to the com port control options.  I believe this is
+	wrong, but it is consistent with other products already in the
+	field.
+
+	* dataxfer.c, ser2net.c, telnet.h: Added support for setting the
+	use of Cisco IOS baud rates instead of RFC 2217 ones, by command
+	option.
+
+	* selector.c, ser2net.c: Cleaned up some compile warnings.
+	
 2003-10-14  Corey Minyard <minyard@acm.org>
 
 	* configure.in: Moved to version 2.0.
Index: configure.in
===================================================================
RCS file: /cvsroot/ser2net/ser2net/configure.in,v
retrieving revision 1.16
retrieving revision 1.17
diff -u -r1.16 -r1.17
--- configure.in	14 Oct 2003 15:29:39 -0000	1.16
+++ configure.in	5 Dec 2003 15:19:41 -0000	1.17
@@ -1,5 +1,5 @@
 AC_INIT(ser2net.c)
-AM_INIT_AUTOMAKE(ser2net, 2.0)
+AM_INIT_AUTOMAKE(ser2net, 2.1)
 AC_PROG_CC
 AM_PROG_LIBTOOL
 AC_ARG_WITH(uucp-locking,
Index: controller.c
===================================================================
RCS file: /cvsroot/ser2net/ser2net/controller.c,v
retrieving revision 1.15
retrieving revision 1.16
diff -u -r1.15 -r1.16
--- controller.c	14 Oct 2003 15:29:39 -0000	1.15
+++ controller.c	5 Dec 2003 15:17:55 -0000	1.16
@@ -17,7 +17,6 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <termios.h>
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/socket.h>
Index: dataxfer.c
===================================================================
RCS file: /cvsroot/ser2net/ser2net/dataxfer.c,v
retrieving revision 1.28
diff -u -r1.28 dataxfer.c
--- dataxfer.c	14 Oct 2003 20:52:13 -0000	1.28
+++ dataxfer.c	5 Dec 2003 20:58:05 -0000
@@ -1878,26 +1878,30 @@
 static struct baud_rates_s {
     int real_rate;
     int val;
+    int cisco_ios_val;
 } baud_rates[] =
 {
-    { 50, B50 },
-    { 75, B75 },
-    { 110, B110 },
-    { 134, B134 },
-    { 150, B150 },
-    { 200, B200 },
-    { 300, B300 },
-    { 600, B600 },
-    { 1200, B1200 },
-    { 1800, B1800 },
-    { 2400, B2400 },
-    { 4800, B4800 },
-    { 9600, B9600 },
-    { 19200, B19200 },
-    { 38400, B38400 },
-    { 57600, B57600 },
-    { 115200, B115200 },
-    { 230400, B230400 },
+    { 50, B50, -1 },
+    { 75, B75, -1 },
+    { 110, B110, -1 },
+    { 134, B134, -1 },
+    { 150, B150, -1 },
+    { 200, B200, -1 },
+    { 300, B300, 3 },
+    { 600, B600 , 4},
+    { 1200, B1200, 5 },
+    { 1800, B1800, -1 },
+    { 2400, B2400, 6 },
+    { 4800, B4800, 7 },
+    { 9600, B9600, 8 },
+    /* We don't support 14400 baud */
+    { 19200, B19200, 10 },
+    /* We don't support 28800 baud */
+    { 38400, B38400, 12 },
+    { 57600, B57600, 13 },
+    { 115200, B115200, 14 },
+    { 230400, B230400, 15 },
+    /* We don't support 460800 baud */
 };
 #define BAUD_RATES_LEN ((sizeof(baud_rates) / sizeof(struct baud_rates_s)))
 
@@ -1906,9 +1910,16 @@
 {
     int i;
     for (i=0; i<BAUD_RATES_LEN; i++) {
-	if (rate == baud_rates[i].real_rate) {
-	    *val = baud_rates[i].val;
-	    return 1;
+	if (cisco_ios_baud_rates) {
+	    if (rate == baud_rates[i].cisco_ios_val) {
+		*val = baud_rates[i].val;
+		return 1;
+	    }
+	} else {
+	    if (rate == baud_rates[i].real_rate) {
+		*val = baud_rates[i].val;
+		return 1;
+	    }
 	}
     }
 
@@ -1921,7 +1932,16 @@
     int i;
     for (i=0; i<BAUD_RATES_LEN; i++) {
 	if (baud_rate == baud_rates[i].val) {
-	    *val = baud_rates[i].real_rate;
+	    if (cisco_ios_baud_rates) {
+		if (baud_rates[i].cisco_ios_val < 0)
+		    /* We are at a baud rate unsopported by the
+		       enumeration, just return zero. */
+		    *val = 0;
+		else
+		    *val = baud_rates[i].cisco_ios_val;
+	    } else {
+		*val = baud_rates[i].real_rate;
+	    }
 	    return;
 	}
     }
@@ -1983,12 +2003,17 @@
 	break;
 
     case 1: /* SET-BAUDRATE */
-	if (len < 6)
-	    return;
+	if (cisco_ios_baud_rates) {
+	    if (len < 3)
+		return;
+	    val = option[2];
+	} else {
+	    if (len < 6)
+		return;
+	    val = ntohl(*((uint32_t *) (option+2)));
+	}
 
-	val = 0;
 	if (tcgetattr(port->devfd, &termio) != -1) {
-	    val = ntohl(*((uint32_t *) (option+2)));
 	    if ((val != 0) && (get_baud_rate(val, &val))) {
 		/* We have a valid baud rate. */
 		cfsetispeed(&termio, val);
@@ -1997,12 +2022,19 @@
 	    }
 	    tcgetattr(port->devfd, &termio);
 	    val = cfgetispeed(&termio);
+	} else {
+	    val = 0;
 	}
 	get_rate_from_baud_rate(val, &val);
 	outopt[0] = 44;
-	outopt[1] = 1;
-	*((uint32_t *) (outopt+2)) = htonl(val);
-	telnet_send_option(&port->tn_data, outopt, 6);
+	outopt[1] = 101;
+	if (cisco_ios_baud_rates) {
+	    outopt[2] = val;
+	    telnet_send_option(&port->tn_data, outopt, 3);
+	} else {
+	    *((uint32_t *) (outopt+2)) = htonl(val);
+	    telnet_send_option(&port->tn_data, outopt, 6);
+	}
 	break;
 
     case 2: /* SET-DATASIZE */
@@ -2030,7 +2062,7 @@
 	    }
 	}
 	outopt[0] = 44;
-	outopt[1] = 2;
+	outopt[1] = 102;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
@@ -2061,7 +2093,7 @@
 		val = 1; /* NONE */
 	}
 	outopt[0] = 44;
-	outopt[1] = 3;
+	outopt[1] = 103;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
@@ -2088,7 +2120,7 @@
 		val = 1; /* 1 stop bit. */
 	}
 	outopt[0] = 44;
-	outopt[1] = 4;
+	outopt[1] = 104;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
@@ -2210,29 +2242,43 @@
 	}
 
 	outopt[0] = 44;
-	outopt[1] = 5;
+	outopt[1] = 105;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
 
     case 8: /* FLOWCONTROL-SUSPEND */
 	tcflow(port->devfd, TCIOFF);
+	outopt[0] = 44;
+	outopt[1] = 108;
+	telnet_send_option(&port->tn_data, outopt, 2);
 	break;
 
     case 9: /* FLOWCONTROL-RESUME */
 	tcflow(port->devfd, TCION);
+	outopt[0] = 44;
+	outopt[1] = 109;
+	telnet_send_option(&port->tn_data, outopt, 2);
 	break;
 
     case 10: /* SET-LINESTATE-MASK */
 	if (len < 3)
 	    return;
 	port->linestate_mask = option[2];
+	outopt[0] = 44;
+	outopt[1] = 110;
+	outopt[2] = port->linestate_mask;
+	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
 
     case 11: /* SET-MODEMSTATE-MASK */
 	if (len < 3)
 	    return;
 	port->modemstate_mask = option[2];
+	outopt[0] = 44;
+	outopt[1] = 111;
+	outopt[2] = port->modemstate_mask;
+	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
 
     case 12: /* PURGE_DATA */
@@ -2247,6 +2293,10 @@
 	break;
     purge_found:
 	tcflush(port->devfd, val);
+	outopt[0] = 44;
+	outopt[1] = 112;
+	outopt[2] = option[2];
+	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
 
     case 6: /* NOTIFY-LINESTATE */
Index: selector.c
===================================================================
RCS file: /cvsroot/ser2net/ser2net/selector.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- selector.c	22 Apr 2003 12:36:51 -0000	1.8
+++ selector.c	5 Dec 2003 14:00:10 -0000	1.9
@@ -548,6 +548,7 @@
 	left = elem->left;
     }
 done:
+    return;
 }
 
 static void
@@ -586,6 +587,7 @@
     print_tree(*top, *last);
     check_tree(*top, *last);
 #endif
+    return;
 }
 
 static void
@@ -662,6 +664,7 @@
     print_tree(*top, *last);
     check_tree(*top, *last);
 #endif
+    return;
 }
 
 int
Index: ser2net.8
===================================================================
RCS file: /cvsroot/ser2net/ser2net/ser2net.8,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -r1.11 -r1.12
--- ser2net.8	14 Oct 2003 20:52:13 -0000	1.11
+++ ser2net.8	5 Dec 2003 14:00:10 -0000	1.12
@@ -36,6 +36,11 @@
 .I \-u
 If UUCP locking is enabled, this will disable the use of UUCP locks.
 .TP
+.I \-b
+Cisco IOS uses a different mechanism for specifying the baud rates
+than the mechanism described in RFC2217.  This option sets the IOS
+version of setting the baud rates.  The default is RFC2217's.
+.TP
 .I \-v
 Prints the version of the program and exits.
 .TP
Index: ser2net.c
===================================================================
RCS file: /cvsroot/ser2net/ser2net/ser2net.c,v
retrieving revision 1.10
diff -u -r1.10 ser2net.c
--- ser2net.c	4 Dec 2002 21:15:26 -0000	1.10
+++ ser2net.c	5 Dec 2003 20:58:05 -0000
@@ -22,12 +22,12 @@
 
 /* TODO
  *
- * Add getty support and UUCP locking
  * Add some type of security
  */
 
 #include <stdio.h>
 #include <signal.h>
+#include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
 #include <sys/types.h>
@@ -46,6 +46,7 @@
 #ifdef USE_UUCP_LOCKING
 int uucp_locking_enabled = 1;
 #endif
+int cisco_ios_baud_rates = 0;
 
 selector_t *ser2net_sel;
 
@@ -58,6 +59,7 @@
 #ifdef USE_UUCP_LOCKING
 "  -u - Disable UUCP locking\n"
 #endif
+"  -b - Do CISCO IOS baud-rate negotiation, instead of RFC2217\n"
 "  -v - print the program's version and exit\n";
 
 void
@@ -96,6 +98,10 @@
 	    debug = 1;
 	    break;
 
+	case 'b':
+	    cisco_ios_baud_rates = 1;
+	    break;
+
 	case 'c':
 	    /* Get a config file. */
 	    i++;
@@ -156,6 +162,7 @@
 
 	/* Detach from the calling terminal. */
 	openlog("ser2net", LOG_PID | LOG_CONS, LOG_DAEMON);
+	syslog(LOG_NOTICE, "ser2net startup");
 	if ((pid = fork()) > 0) {
 	    exit(0);
 	} else if (pid < 0) {
Index: ser2net.spec
===================================================================
RCS file: /cvsroot/ser2net/ser2net/ser2net.spec,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -r1.11 -r1.12
--- ser2net.spec	5 Dec 2003 14:01:01 -0000	1.11
+++ ser2net.spec	5 Dec 2003 15:19:41 -0000	1.12
@@ -1,5 +1,5 @@
 Name:		ser2net
-Version:	2.0
+Version:	2.1
 Release:	1
 License:	GPL
 Summary:	Serial to network proxy
@@ -38,6 +38,8 @@
 
 
 %changelog
+* Tue Dec  5 2003 Corey Minyard <minyard@acm.org>
+- Moved to version 2.1.
 * Tue Oct 14 2003 Corey Minyard <minyard@acm.org>
 - Moved to version 2.0.
 * Tue Apr 22 2003 Corey Minyard <minyard@acm.org>
Index: telnet.c
===================================================================
RCS file: /cvsroot/ser2net/ser2net/telnet.c,v
retrieving revision 1.2
diff -u -r1.2 telnet.c
--- telnet.c	14 Oct 2003 16:09:43 -0000	1.2
+++ telnet.c	5 Dec 2003 20:58:05 -0000
@@ -205,7 +205,7 @@
 		}
 	    } else {
 		/* It's in a suboption, look for the end and IACs. */
-		if (td->telnet_cmd[td->telnet_cmd_pos-1] == 255) {
+	      if (td->suboption_iac) {
 		    if (tn_byte == 240) {
 			/* Remove the IAC 240 from the end. */
 			td->telnet_cmd_pos--;
@@ -219,6 +219,7 @@
 			   character, delete them both */
 			td->telnet_cmd_pos--;
 		    }
+		    td->suboption_iac = 0;
 		} else {
 		    if (td->telnet_cmd_pos > MAX_TELNET_CMD_SIZE)
 			/* Always store the last character
@@ -230,12 +231,15 @@
 	  
 		    td->telnet_cmd[td->telnet_cmd_pos] = tn_byte;
 		    td->telnet_cmd_pos++;
+		    if (tn_byte == 255)
+		      td->suboption_iac = 1;
 		}
 	    }
 	} else if (data[i] == 255) {
 	    td->telnet_cmd[td->telnet_cmd_pos] = 255;
 	    len = delete_char(data, i, len);
 	    td->telnet_cmd_pos++;
+	    td->suboption_iac = 0;
 	} else {
 	    i++;
 	}
Index: telnet.h
===================================================================
RCS file: /cvsroot/ser2net/ser2net/telnet.h,v
retrieving revision 1.2
diff -u -r1.2 telnet.h
--- telnet.h	14 Oct 2003 16:09:43 -0000	1.2
+++ telnet.h	5 Dec 2003 20:58:05 -0000
@@ -52,6 +52,9 @@
 					   telnet_cmd buffer.  If zero,
 					   no telnet command is in
 					   progress. */
+    int            suboption_iac;	/* If true, we are in a
+					   suboption and processing an
+					   IAC. */
 
     /* Outgoing telnet commands.  The output routines should look at
        this *first* to see if they should transmit some data from
@@ -96,5 +99,9 @@
 		 struct telnet_cmd *cmds,
 		 unsigned char *init_seq,
 		 int init_seq_len);
+
+/* Set to true if we are supposed to do CISCO IOS baud rates instead
+   of RFC2217 ones. */
+extern int cisco_ios_baud_rates;
 
 #endif /* _SER2NET_TELNET_H */

--------------070106000202060107040905--

