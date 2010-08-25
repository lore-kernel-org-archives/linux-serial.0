From: Michal Simek <monstr@monstr.eu>
Subject: uartlite - fix poll support
Date: Wed, 25 Aug 2010 14:55:03 +0200
Message-ID: <1282740904-1244-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, gregkh@suse.de
List-Id: linux-serial@vger.kernel.org

Hi,

I forget to CC Peter Korsgaard (sorry for that again) and he found one obscure thing
in my first patch. This second patch removes it. It will be the best
to add those two patches together but I am not sure if is possible. It depends
on Greg maintaining process. (If is possible I would like to ask for it).

Peter: I added your Signed-off-by line I hope that you are OK with it.

Greg: If there are no problems with it, please add to your tty tree or add together
with the first patch.

Thanks,
Michal
