From: Chen Gang <gang.chen@asianux.com>
Subject: [Suggestion] drivers/tty/serial: sprintf for filename[32].
Date: Sat, 01 Dec 2012 18:01:04 +0800
Message-ID: <50B9D560.8090003@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:50288 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab2LAKAO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Dec 2012 05:00:14 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Hello Alan Cox:

in drives/tty/serial/ucc_uart.c:
  at line 1231, the filename buffer length is 32.
  at line 1242, "fsl_qe_ucode_uart_%u_%u%u.bin" is 23 + 3*%u.
  at line 1237, after call soc_info. soc within 4 bytes, rev_h within 2 bytes, rev_l within 2 bytes.

my suggestion is:
  use "fsl_qe_ucode_uart_%.4u_%.2u%.2u.bin" instead of "fsl_qe_ucode_uart_%u_%u%u.bin";
  or use "char filename[64]" instead of "char filename[32]".
  please give your choice (or provide new choice).

  it is not a bug, it is only to make source code clearer or extensible.

  thanks.


1231                 } else {
1232                         char filename[32];
1233                         unsigned int soc;
1234                         unsigned int rev_h;
1235                         unsigned int rev_l;
1236 
1237                         soc = soc_info(&rev_h, &rev_l);
1238                         if (!soc) {
1239                                 dev_err(&ofdev->dev, "unknown CPU model\n");
1240                                 return -ENXIO;
1241                         }
1242                         sprintf(filename, "fsl_qe_ucode_uart_%u_%u%u.bin",
1243                                 soc, rev_h, rev_l);
1244 
1245                         dev_info(&ofdev->dev, "waiting for firmware %s\n",
1246                                 filename);
1247 



-- 
Chen Gang

Asianux Corporation
