From: Dmitry Artamonow <mad_soft@inbox.lv>
Subject: Re: [BUG] tty/serial: stty hangs for 30 seconds after interrupted
 transfer
Date: Thu, 25 May 2017 16:43:28 +0300
Message-ID: <6fab5ab4-4f7a-478d-2a5c-1fe77aa4609f@inbox.lv>
References: <c87da751-0692-e381-be16-a2adf0f0104f@inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c87da751-0692-e381-be16-a2adf0f0104f@inbox.lv>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Update: the problem reproduces also on x86-64 with 8250 driver.

root@madhouse:~# uname -a
Linux madhouse 4.12.0-rc2+ #2 SMP Thu May 25 12:08:00 MSK 2017 x86_64 x86_64 x86_64 GNU/Linux
root@madhouse:~# time stty -F /dev/ttyS0
speed 9600 baud; line = 0;
-brkint -imaxbel

real    0m0.010s
user    0m0.011s
sys     0m0.000s
root@madhouse:~# cat blah > /dev/ttyS0
^C
root@madhouse:~# time stty -F /dev/ttyS0
speed 9600 baud; line = 0;
-brkint -imaxbel

real    0m30.732s
user    0m0.011s
sys     0m0.002s
root@madhouse:~#

--
Best regards
Dmitry Artamonow
