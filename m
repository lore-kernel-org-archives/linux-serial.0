From: Colin Ian King <colin.king@canonical.com>
Subject: re: serial: Add Milbeaut serial control
Date: Thu, 2 May 2019 12:47:39 +0100
Message-ID: <246f81ba-0ed1-d5bc-1a48-bcf0fb2cc05e@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

Static analysis with Coverity has picked up an issue in commit:

commit ba44dc04300441b47618f9933bf36e75a280e5fe
Author: Sugaya Taichi <sugaya.taichi@socionext.com>
Date:   Mon Apr 15 20:31:40 2019 +0900

    serial: Add Milbeaut serial control

In function mlb_usio_rx_chars() the u8 status is being bit-wise AND'd
with MLB_USIO_SSR_BRK (which is 1UL << 8) and hence the result is always
false, which looks incorrect to me.  Is this intentional?

Colin
