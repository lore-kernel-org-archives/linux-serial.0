From: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Subject: Re: What's the rationale behind sending a Xoff character when the
 port is stopped ?
Date: Mon, 7 May 2012 16:47:51 -0500
Message-ID: <CAES2cWxoxNG-L5hK67jH3uug9KScq=rvcqE_f+B3MaRNGDL1FA@mail.gmail.com>
References: <CAES2cWwz=JJY14rCX8_GwnD7Mgmweiz9xSUsw6z08YZ2zNHkqw@mail.gmail.com>
 <20120507215059.3111018f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58789 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab2EGVsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 17:48:13 -0400
Received: by lahd3 with SMTP id d3so641469lah.19
        for <linux-serial@vger.kernel.org>; Mon, 07 May 2012 14:48:11 -0700 (PDT)
In-Reply-To: <20120507215059.3111018f@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

In the case when I am flow controlled (meaning I received a Xoff from
the other end) and my receive buffer fills up, sending a Xoff to the
other end might overflow the buffer for the other guy, right ? Is that
Ok ?

On Mon, May 7, 2012 at 3:50 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
> On Mon, 7 May 2012 15:00:50 -0500
> Karthik Manamcheri <karthik.manamcheri@gmail.com> wrote:
>
>> Hi,
>>
>> I noticed in drivers/tty/serial/8250.c that when we transmit
>> characters (by calling transmit_chars), we check for uart_tx_stopped
>> only after sending the x_char (if any). What's the rationale behind
>> this ? I would expect the uart not to send ANY characters (including=
 a
>> Xoff character) if its throttled (or stopped).
>
> We implement xon/xoff flow control. Therefore we need to send charact=
ers
> when throttled.
>
> Think about the case where you are flow controlled for transmit and y=
our
> receive buffer fills up...
>
> Alan



--=20
Karthik Manamcheri
Software R&D=A0|=A0Instrument Control Products=A0|=A0National Instrumen=
ts
http://www.karthikmanamcheri.com
http://www.linkedin.com/in/kmanamcheri
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
