From: Mason <slash.tmp@free.fr>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Tue, 12 Jan 2016 23:26:19 +0100
Message-ID: <56957D8B.3080906@free.fr>
References: <5672D18E.8000301@laposte.net>
 <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net>
 <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net>
 <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net>
 <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net>
 <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net>
 <5693D41E.8050601@hurleysoftware.com> <5693ECBA.50003@laposte.net>
 <5693FD3C.5080601@hurleysoftware.com> <5694C94B.3090405@free.fr>
 <56950C21.3010805@laposte.net> <5695584E.3040902@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5695584E.3040902@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Frias <sf84@laposte.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On 12/01/2016 20:47, Peter Hurley wrote:

> I expect that patch to go into -next sometime during the 4.5-rc cycle.

Do you mean the "Add Au1x00/RT288x earlycon support" patch?

I find it strange that you have rt288x_putc while also
using AU1x00_FOO. Seems like mixing naming styles.

Did you see my post about the underlying IP block?
Might be appropriate to use that name there?

Regards.
