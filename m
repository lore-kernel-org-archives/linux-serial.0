From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH 0/2] Perfect 8250 mtk uart function.
Date: Thu, 25 Apr 2019 16:41:29 +0800
Message-ID: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Long Cheng <long.cheng@mediatek.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Shih <pihsun@chromium.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>, Changqi Hu <changqi.hu@mediatek.com>
List-Id: linux-serial@vger.kernel.org

Perfect 8250 mtk uart function,
1.Modify baudrate setting
2.Add follow control function

Long Cheng (2):
  serial: 8250-mtk: add follow control
  serial: 8250-mtk: modify baudrate setting

 drivers/tty/serial/8250/8250_mtk.c | 162 +++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 23 deletions(-)

-- 
1.9.1
