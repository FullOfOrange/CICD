const { makeUUID } = require('../server')

test('UUID 테스트', () => {
    const getuuid = makeUUID();
    expect(getuuid()).toBe(getuuid());
})