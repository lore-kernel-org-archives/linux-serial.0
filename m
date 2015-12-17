From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Thu, 17 Dec 2015 15:23:55 +0000
Message-ID: <yw1xwpsdcd4k.fsf@unicorn.mansr.com>
References: <5672D18E.8000301@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5672D18E.8000301@laposte.net> (Sebastian Frias's message of
	"Thu, 17 Dec 2015 16:15:26 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>
List-Id: linux-serial@vger.kernel.org

Sebastian Frias <sf84@laposte.net> writes:

> - reading/writing to UART_DLL/UART_DLM directly are converted to usin=
g
> the read_dl/write_dl callbacks.

This should be an obvious fix.  Please send that as a separate patch.

--=20
M=E5ns Rullg=E5rd
