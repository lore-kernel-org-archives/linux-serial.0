From: Shyam Saini <mayhs11saini@gmail.com>
Subject: junk character issue on minicom and screen
Date: Mon, 24 Jun 2019 14:57:34 +0530
Message-ID: <CAOfkYf4kCTWdjDJSG0=KgZZG7F+HpE+m+RbgLZ=NeczZ5uWPRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: linux-serial@vger.kernel.org
Cc: Kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

Hello everyone,

I'm working on Rockchip rk3399 Nanopc t4 board and I'm trying get serial output
from board using minicom and my board has baudrate 1500000.

I'm using a usb to serial converter. So, when i power on my board minicom starts
to give junk characters.
Minicom version:  2.7.1
USB driver probed : cp210x

But when I use the same setup with my colleagues laptop it gives correct output
(kernel version 4.15.0-52-generic ).

Note that my colleague and i used same setup
Same usb driver probed
Same power adapter
same usb to serial converter wire
same minicom version.
same baudrate

Other thing which i tried is switching kernel version and it turns out
that one of the older
distro kernel on my system (debian 4.9.0-5-amd64 ) is working fine and
it seems like
there is something changed in newer kernel vesions.
Here is the quick summary
4.19.0-4-amd64    -> not working
4.15.0-52-generic -> working
4.9.0-5-amd64      -> working
5.2.0-rc4+             -> not working

Did anyone else faced the similar problem.
Is there any patch available if it is bug ?
Please let me know.

Thanks a lot,
Shyam
