From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] tty (or char) bus?
Date: Tue, 14 Jul 2009 17:31:23 +0200
Message-ID: <4A5CA4CB.8070500@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-serial@vger.kernel.org

Hi,

In my attempt to add support for contols to a voice modem codec sound 
device driver, I found that in order to talk to the modem, it would be 
convenient if I can get access to a tty device from inside the kernel in 
a way similiar to that available form userspace. AFAICS, even if tty 
lowlevel write() could be used unmodified, a convenient way of reading 
characters from a tty is missing and should be implemented in a line 
discipline. Please correct me if I am wrong.

OTOH, I found that some kind of abstraction layer for acccessing devices 
over a tty could be convenient. Instead of allocating a new line 
discipline for each specific device, sometimes found on a specific board 
only, why not just create a new bus type?

Implemented as a line discipline, activated (hot-plugged) from userspace 
with ldattach, that new bus adapter would give kernel level access to an 
arbitrary device hanging off a tty. As the bus can be assumed 
point-to-point, a single generic device could be registered 
automatically in order to trigger that bus registerd drivers' probes 
(vendor/model id queries, for example). If not enough, an ioctl and a 
ldattach replacement could be provided for setting up a device id that 
would match a driver id (something like inputattach does for N_MOUSE).

Once detected by a voice modem codec driver tty bus probe(), a codec 
subdevice could then be registered with a sound card.

Please let me know if you like the idea. If not, please push me in a 
better direction.

Many of the new code could be probably based on currently existing 
drivers and line discplines. As I'm not familiar enough with the linux 
kernel code, unlike most of you, so please give me some hints on what 
specific drivers should I look at to get examples best matching my idea.

Thanks,
Janusz
