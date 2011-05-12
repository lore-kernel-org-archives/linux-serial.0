From: "Watkins, Melissa" <m-watkins@ti.com>
Subject: Serial driver parity support
Date: Thu, 12 May 2011 12:29:51 -0500
Message-ID: <131E5DFBE7373E4C8D813795A6AA7F08034B0550CA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758008Ab1ELR3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 May 2011 13:29:53 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CHTqup014590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Thu, 12 May 2011 12:29:52 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4CHTqoG004044
	for <linux-serial@vger.kernel.org>; Thu, 12 May 2011 12:29:52 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p4CHTqNo021366
	for <linux-serial@vger.kernel.org>; Thu, 12 May 2011 12:29:52 -0500 (CDT)
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

All,

I am working to implement parity support for a serial driver.=A0 I had =
several general questions about how serial drivers should handle parity=
 and parity errors.

1. The serial driver sets TTY_DRIVER_REAL_RAW.=A0 My understanding of  =
	TTY_DRIVER_REAL_RAW is that, if set, the driver will only send the 	mi=
nimum notifications of parity errors required or according to the 	c_if=
lags.=A0 For example, regarding parity errors:

   ! (INPCK)=A0=A0=A0=A0     --  char with PE will be pushed as TTY_NOR=
MAL
   INPCK & !(IGNPAR) --=A0 char with PE will be pushed as TTY_PARITY
   INPCK & IGNPAR=A0=A0=A0=A0--=A0 char with PE will be discarded and n=
ot pushed

=A0=A0 =A0=A0=A0Is my understanding correct?

2. When receiving characters, I am pushing a block of characters (<=3D =
16) at 	a time to the TTY data structure. =A0If a parity error occurs o=
n the 8th 	character, should I push the entire block of data with the T=
TY_PARITY 	flag? =A0Or should I first push the first 7 characters with =
the 	TTY_NORMAL flag and the 8th character separately with the TTY_PARI=
TY 	flag? =A0

3. Is there a priority given to BI, FE, and PE errors? =A0For example, =
if more 	than one of these errors occurs for a single character, should=
 all 	errors be flagged?=A0 Or is one error given priority, and (depend=
ing on 	the c_iflag settings) the character is pushed with the flag set=
 to 	this type of error?

4. Should I ever push the parity bit to TTY? =A0Or should the parity bi=
t 	always be removed first?

Thanks in advance for your advice.

Regards,
Melissa Watkins
Texas Instruments
ARM MPU Hardware Apps
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
