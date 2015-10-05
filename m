From: Fabio Estevam <festevam@gmail.com>
Subject: Re: IMX6 serial fuckage
Date: Mon, 5 Oct 2015 17:33:15 -0300
Message-ID: <CAOMZO5A_aZFJPMgSqDezi5KY3BJ-ywCwK7rUno=WqTXjmQOnCw@mail.gmail.com>
References: <20151005202718.GL21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151005202718.GL21513@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eduardo Valentin <edubezval@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 5, 2015 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Greg,
>
> Please revert this commit:
>
> commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d
> Author: Eduardo Valentin <edubezval@gmail.com>
> Date:   Tue Aug 11 10:21:20 2015 -0700

Already reverted in Greg's tree:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=0c727a42043f79db210cdde0366f9137b9c6bf5a

Should be available in 4.3-rc5.
