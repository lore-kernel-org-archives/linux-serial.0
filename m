From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
Date: Fri, 3 May 2019 12:05:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1905031141530.4777@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
 <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
 <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com>
 <7htvetbupi.fsf@baylibre.com>
 <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
 <7hsgtwlm5t.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <7hsgtwlm5t.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Atish Patra <atish.patra@wdc.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 2 May 2019, Kevin Hilman wrote:

> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
> > I'd recommend testing the DT patches with BBL and the open-source FSBL.  
> > That's the traditional way of booting RISC-V Linux systems.
> 
> OK, but as you know, not the tradiaional way of booting most other linux
> systems.  ;)
> 
> I'm working on getting RISC-V supported in kernelCI in a fully-automated
> way, and I don't currently have the time to add add support for BBL+FSBL
> to kernelCI automation tooling, so having u-boot support is the best way
> to get support in kernelCI, IMO.

That's great.  Please keep hacking away on RISC-V support for kernelCI.  
My point is just that the U-boot and OpenSBI software stack you're working 
with is not going to be useful for automatic tests of some kernel patches 
yet.  That stack is still very new, and was written around a non-upstream 
set of DT data.  We are in the process of posting and merging patches to 
fix that, but it's going to take a few releases of both the kernel and 
those other boot stack components until things are sorted out in a more 
durable way.


- Paul
