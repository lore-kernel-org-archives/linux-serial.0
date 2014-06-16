From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH tty-next 15/22] isdn: tty: Use private flag for
 ASYNC_CLOSING
Date: Mon, 16 Jun 2014 15:37:44 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1725D13A@AcuExch.aculab.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-16-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:33226 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755371AbaFPPiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jun 2014 11:38:54 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 24822-02 for <linux-serial@vger.kernel.org>;
 Mon, 16 Jun 2014 16:38:44 +0100 (BST)
In-Reply-To: <1402924639-5164-16-git-send-email-peter@hurleysoftware.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Peter Hurley' <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Karsten Keil <isdn@linux-pingi.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

From: Of Peter Hurley
> ASYNC_CLOSING is no longer used in the tty core; use private flag
> info->closing as substitute.
...
> @@ -311,6 +311,7 @@ typedef struct atemu {
>  typedef struct modem_info {
>    int			magic;
>    struct tty_port	port;
> +  int			closing:1;	 /* port count has dropped to 0    */
>    int			x_char;		 /* xon/xoff character             */
>    int			mcr;		 /* Modem control register         */
>    int                   msr;             /* Modem status register          */

That should probably be a bool and set to true/false.
You are probably adding a load of padding.

	David



