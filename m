From: Corey Minyard <minyard@acm.org>
Subject: Re: Serial port redirection
Date: Wed, 03 Dec 2003 07:31:55 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FCDE5CB.4090303@acm.org>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000705030608070106010600"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:29869 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261719AbTLDRc6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Dec 2003 12:32:58 -0500
In-Reply-To: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se>
List-Id: linux-serial@vger.kernel.org
To: Peter Astrand <peter@cendio.se>
Cc: ltsp-discuss@lists.sourceforge.net, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------000705030608070106010600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've attached a ser2net patch for this.  Could you try it out?

-Corey

Peter Astrand wrote:

>* ser2net is totally incompatible with cyclades-serial-client. This is
>because ser2net interprets RFC2217 a bit differently. sredird sends
>command "101" as ack for command "1", while ser2net sends "1". RFC2217 is
>not very explicit about which way is most correct. The ser2net approach
>looks better to me, but the sredird one is probably more widely used
>(since Cyclades terminal server uses it, for example.) Probably, RFC2217
>software needs to handle both cases.
>
>  
>


--------------000705030608070106010600
Content-Type: text/plain;
 name="ser2net-com-option.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ser2net-com-option.diff"

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
+++ ChangeLog	4 Dec 2003 17:31:04 -0000
@@ -1,4 +1,11 @@
 
+2003-12-04  Corey Minyard <minyard@acm.org>
+
+	* dataxfer.c: Have the telnet option responses use the 1xx
+	responses to the com port control options.  I believe this is
+	wrong, but it is consistent with other products already in the
+	field.
+
 2003-10-14  Corey Minyard <minyard@acm.org>
 
 	* configure.in: Moved to version 2.0.
Index: dataxfer.c
===================================================================
RCS file: /cvsroot/ser2net/ser2net/dataxfer.c,v
retrieving revision 1.28
diff -u -r1.28 dataxfer.c
--- dataxfer.c	14 Oct 2003 20:52:13 -0000	1.28
+++ dataxfer.c	4 Dec 2003 17:31:04 -0000
@@ -2000,7 +2000,7 @@
 	}
 	get_rate_from_baud_rate(val, &val);
 	outopt[0] = 44;
-	outopt[1] = 1;
+	outopt[1] = 101;
 	*((uint32_t *) (outopt+2)) = htonl(val);
 	telnet_send_option(&port->tn_data, outopt, 6);
 	break;
@@ -2030,7 +2030,7 @@
 	    }
 	}
 	outopt[0] = 44;
-	outopt[1] = 2;
+	outopt[1] = 102;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
@@ -2061,7 +2061,7 @@
 		val = 1; /* NONE */
 	}
 	outopt[0] = 44;
-	outopt[1] = 3;
+	outopt[1] = 103;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
@@ -2088,7 +2088,7 @@
 		val = 1; /* 1 stop bit. */
 	}
 	outopt[0] = 44;
-	outopt[1] = 4;
+	outopt[1] = 104;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;
@@ -2210,7 +2210,7 @@
 	}
 
 	outopt[0] = 44;
-	outopt[1] = 5;
+	outopt[1] = 105;
 	outopt[2] = val;
 	telnet_send_option(&port->tn_data, outopt, 3);
 	break;

--------------000705030608070106010600--

