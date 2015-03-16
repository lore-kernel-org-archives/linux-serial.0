From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 05/35 linux-next] tty: constify of_device_id array
Date: Mon, 16 Mar 2015 14:20:14 -0500
Message-ID: <55072CEE.7060103@tabi.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Alexandre Courbot <gnurou@gmail.com>, Barry Song <baohua@kernel.org>, kernel@stlinux.com, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org, Patrice Chotard <patrice.chotard@st.com>, Michal Simek <michal.simek@xilinx.com>, Thierry Reding <thierry.reding@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-tegra@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.cz>, =?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Maxime Coquelin <maxime.coquelin@st.com>
List-Id: linux-serial@vger.kernel.org

On 03/16/2015 02:17 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick<fabf@skynet.be>

...

>   drivers/tty/serial/ucc_uart.c               | 2 +-

For this driver:

Acked-by: Timur Tabi <timur@tabi.org>
