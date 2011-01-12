From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH resend 2] Add sc16is7x2 driver
Date: Wed, 12 Jan 2011 12:05:54 +0100
Message-ID: <4D2D8B12.2@gmail.com>
References: <4D272DDA.6010007@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D272DDA.6010007@iis.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Weber <weber@corscience.de>, Johannes Reif <reif@corscience.de>, changgx <changgx@163.com>, miguelangel@nbee.es
List-Id: linux-serial@vger.kernel.org

Am 07.01.2011 16:14, schrieb Manuel Stahl:
> IRQ is now implemented with work queue (like max3100).
> The problem is, that the sc16is7x2 has a low active irq. But with active
> low threaded_irqs, shared irqs are not allowed.
> 
> Please try this one and report errors.
> 
> Regards,
> Manuel Stahl
> 
> PS: sorry that the patch is not inline, not sure how to configure
> thunderbird correctly

Hello Manuel,

There is a re-definition of PORT_SC16IS7X2 in serial_core.h
First time it is 20, second time it is 98.

Regards,
Thomas
