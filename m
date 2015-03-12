From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 06/10] drivers: PL011: replace UART_MIS reading with
 _RIS & _IMSC
Date: Thu, 12 Mar 2015 10:46:51 +0000
Message-ID: <20150312104651.GJ8656@n2100.arm.linux.org.uk>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-7-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1425491994-23913-7-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: rob.herring@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 05:59:50PM +0000, Andre Przywara wrote:
> The PL011 register UART_MIS is actually a bitwise AND of the
> UART_RIS and the UART_MISC register.
> Since the SBSA UART does not include the _MIS register, use the
> two separate registers to get the same behaviour. Since we are
> inside the spinlock and we read the _IMSC register only once, there
> should be no race issue.

Do we really need to go all the way to the hardware for this?  Isn't
uap->im sufficient?  Reading from memory is potentially faster as it
could be in the CPU caches.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
