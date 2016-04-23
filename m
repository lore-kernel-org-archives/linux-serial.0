From: Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 0/2] tty: serial: msm_serial regression and add info message
Date: Sat, 23 Apr 2016 10:10:35 -0700
Message-ID: <571BAC8B.80001@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

Commit 3a878c430fd6 ("tty: serial: msm: Add TX DMA support") resulted
in dropped characters and invalid characters in pio mode.  Fix the
problem and add an additional information message that was important
in diagnosing the problem (reporting that DMA mode was not enabled).
