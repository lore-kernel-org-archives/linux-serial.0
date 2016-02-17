From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/5] serial: 8250: fixes for modular build
Date: Wed, 17 Feb 2016 16:02:30 +0100
Message-ID: <1455721357-4008289-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

This is a resend of my last week's 8250 series, with a couple of
issues fixed as pointed out by Paul Gortmaker.

Masahiro Yamada had an idea for a nicer solution to the problem of
a modular build, but after some back and forth, the conclusion was
that this does not work any more after the rework done by
Peter Hurley, so we are back to my original approach.

I've done many compile tests over the last week and found another
corner case in the Ingenic driver patch, which is now also fixed,
and I'm no longer getting any invalid symbol references here or
in other drivers.

	Arnd
