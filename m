From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/6] serial: 8250: fixes for modular build
Date: Thu, 11 Feb 2016 16:41:26 +0100
Message-ID: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a re-send of three patches I sent a couple of days ago,
with a revert of two patches that Paul did, taking the code in
the opposite direction now, towards ensuring the drivers actually
work as loadable modules, which helps with 'allmodconfig' build
testing.

I've also added another patch for uniphier, and fixed smaller
related issues that came up in further testing.

	Arnd
