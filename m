From: Muni Sekhar <munisekharrms@gmail.com>
Subject: serial: custom baud rate
Date: Thu, 3 May 2018 18:09:13 +0530
Message-ID: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi All,

>From include/asm-generic/termbits.h , I see baudrate can be one of the
standard values: 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800,
2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800, 500000,
576000, 921600, 1000000, 1152000, 1500000, 2000000, 2500000, 3000000,
3500000, 4000000.


If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
Linux serial framework has any supporting method?



-- 
Thanks,
Sekhar
