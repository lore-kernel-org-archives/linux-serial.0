From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 0/3] serial: xuartps: hardware race condition and cleanup
Date: Mon, 4 Jun 2018 12:21:56 +0200
Message-ID: <cover.1528106392.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
List-Id: linux-serial@vger.kernel.org

The character transmission in xuartps is racy. If the transmitter is disabl=
ed
early, the device is confused and produces a desync. Garbage on the remote =
end
can be a visible symptom. The second patch in this series tries to reduce t=
hat
race condition in accordance with the hardware documentation, but it cannot
remove it entirely. The first and third patches are code cleanup.

Changes since v2:
 * Do not attempt to disable the transmitter after a transmission (original
   behaviour around 3.14). These patches no longer touch with the transmitt=
er
   state at all as requested by S=F6ren Brinkmann.
 * Add Acked-by/Reviewed-by tags from S=F6ren Brinkmann after addressing his
   remarks.

Earlier patches/discussion at:
    https://www.spinics.net/lists/linux-serial/msg23145.html
    https://www.spinics.net/lists/linux-serial/msg23156.html
    https://www.spinics.net/lists/linux-serial/msg23157.html

Helmut Grohne (3):
  serial: xuartps: fix typo in cdns_uart_startup
  serial: xuartps: reduce hardware TX race condition
  serial: xuartps: remove unnecessary register write

 drivers/tty/serial/xilinx_uartps.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

-- =

2.11.0
